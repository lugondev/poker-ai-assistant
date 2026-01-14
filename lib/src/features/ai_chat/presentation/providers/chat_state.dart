import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chat_message.dart';

part 'chat_state.freezed.dart';

/// State for the AI Chat feature
@freezed
abstract class ChatState with _$ChatState {
  const ChatState._();

  const factory ChatState({
    /// List of chat messages
    @Default([]) List<ChatMessage> messages,

    /// Is the chat panel open
    @Default(false) bool isOpen,

    /// Is AI currently generating a response
    @Default(false) bool isTyping,

    /// Content being streamed (partial response)
    @Default('') String streamingContent,

    /// Error message if something failed
    @Default(null) String? errorMessage,

    /// Quick action suggestions based on context
    @Default([]) List<QuickAction> quickActions,

    /// Current game context snapshot
    @Default(null) GameContextSnapshot? currentContext,

    /// Number of unread messages
    @Default(0) int unreadCount,

    /// FAB position (null = default position)
    @Default(null) Offset? fabPosition,
  }) = _ChatState;

  /// Check if there are any messages
  bool get hasMessages => messages.isNotEmpty;

  /// Check if there are unread messages
  bool get hasUnread => unreadCount > 0;

  /// Get the last message
  ChatMessage? get lastMessage => messages.isNotEmpty ? messages.last : null;
}
