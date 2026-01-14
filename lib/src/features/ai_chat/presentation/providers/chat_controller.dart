import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/ai_models.dart';
import '../../domain/entities/chat_message.dart';
import 'ai_service_provider.dart';
import 'chat_state.dart';
import 'game_context_provider.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  int _messageIdCounter = 0;

  @override
  ChatState build() {
    // Watch game context and update state when it changes
    final gameContext = ref.watch(gameContextProvider);
    final quickActions = ref.watch(contextQuickActionsProvider);

    // Schedule context update after build completes
    Future.microtask(() {
      if (state.currentContext != gameContext) {
        state = state.copyWith(
          currentContext: gameContext,
          quickActions: quickActions,
        );
      }
    });

    return ChatState(quickActions: quickActions, currentContext: gameContext);
  }

  /// Generate unique message ID
  String _generateMessageId() {
    _messageIdCounter++;
    return 'msg_${DateTime.now().millisecondsSinceEpoch}_$_messageIdCounter';
  }

  /// Open the chat panel
  void openChat() {
    state = state.copyWith(isOpen: true, unreadCount: 0);
  }

  /// Close the chat panel
  void closeChat() {
    state = state.copyWith(isOpen: false);
  }

  /// Toggle chat panel
  void toggleChat() {
    if (state.isOpen) {
      closeChat();
    } else {
      openChat();
    }
  }

  /// Send a message from user
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: _generateMessageId(),
      content: content.trim(),
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      context: state.currentContext,
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
      errorMessage: null,
    );

    // Get AI service and generate response
    await _generateAiResponse(content);
  }

  /// Send a quick action
  Future<void> sendQuickAction(QuickAction action) async {
    await sendMessage(action.prompt);
  }

  /// Generate AI response using the configured AI service
  Future<void> _generateAiResponse(String userMessage) async {
    final aiService = ref.read(aiServiceProvider);
    final context = state.currentContext;

    // Build system prompt with game context
    final systemPrompt = PokerSystemPrompt.build(
      heroCards: context?.heroCards,
      boardCards: context?.boardCards,
      boardPhase: context?.boardPhase,
      opponentCount: context?.opponentCount,
      potSize: context?.potSize,
      heroEquity: context?.heroEquity,
      heroHandRank: context?.heroHandRank,
      amountToCall: context?.amountToCall,
      potOddsRatio: context?.potOddsRatio,
    );

    // Build messages for AI
    final messages = [
      AiMessage(role: 'system', content: systemPrompt),
      // Include recent conversation history (last 10 messages)
      ...state.messages
          .take(10)
          .map(
            (m) => AiMessage(
              role: m.sender == MessageSender.user ? 'user' : 'assistant',
              content: m.content,
            ),
          ),
      AiMessage(role: 'user', content: userMessage),
    ];

    final request = AiCompletionRequest(messages: messages);

    try {
      String streamedContent = '';

      await for (final chunk in aiService.streamCompletion(request)) {
        if (chunk.error != null) {
          state = state.copyWith(
            isTyping: false,
            streamingContent: '',
            errorMessage: chunk.error,
          );

          // Add error as system message
          addSystemMessage('Error: ${chunk.error}');
          return;
        }

        if (chunk.isDone) {
          break;
        }

        streamedContent += chunk.content;
        state = state.copyWith(streamingContent: streamedContent);
      }

      // Finalize AI message
      if (streamedContent.isNotEmpty) {
        final aiMessage = ChatMessage(
          id: _generateMessageId(),
          content: streamedContent,
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );

        state = state.copyWith(
          messages: [...state.messages, aiMessage],
          streamingContent: '',
          isTyping: false,
        );

        // If chat is not open, increment unread
        if (!state.isOpen) {
          state = state.copyWith(unreadCount: state.unreadCount + 1);
        }
      } else {
        state = state.copyWith(streamingContent: '', isTyping: false);
      }
    } catch (e) {
      state = state.copyWith(
        isTyping: false,
        streamingContent: '',
        errorMessage: 'Failed to get AI response: $e',
      );

      addSystemMessage('Connection error. Please try again.');
    }
  }

  /// Clear chat history
  void clearHistory() {
    state = state.copyWith(
      messages: [],
      streamingContent: '',
      isTyping: false,
      errorMessage: null,
    );
  }

  /// Add a system message
  void addSystemMessage(String content) {
    final systemMessage = ChatMessage(
      id: _generateMessageId(),
      content: content,
      sender: MessageSender.system,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(messages: [...state.messages, systemMessage]);
  }

  /// Update FAB position
  void updateFabPosition(Offset? position) {
    state = state.copyWith(fabPosition: position);
  }
}
