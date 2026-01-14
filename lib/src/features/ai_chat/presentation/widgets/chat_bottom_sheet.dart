import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/chat_message.dart';
import '../providers/chat_controller.dart';
import '../providers/chat_state.dart';
import 'chat_input_field.dart';
import 'message_bubble.dart';

/// Bottom sheet containing the AI chat interface
class ChatBottomSheet extends ConsumerStatefulWidget {
  const ChatBottomSheet({super.key});

  @override
  ConsumerState<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends ConsumerState<ChatBottomSheet> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);

    // Scroll to bottom when new messages arrive
    ref.listen(chatControllerProvider, (previous, next) {
      if (previous?.messages.length != next.messages.length ||
          previous?.streamingContent != next.streamingContent) {
        _scrollToBottom();
      }
    });

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: const [0.3, 0.6, 0.9],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle
              _buildDragHandle(),
              // Header
              _buildHeader(controller),
              // Context bar (if available)
              if (chatState.currentContext != null)
                _buildContextBar(chatState.currentContext!),
              // Divider
              Divider(height: 1, color: Colors.white.withValues(alpha: 0.1)),
              // Messages list
              Expanded(
                child: chatState.hasMessages || chatState.isTyping
                    ? _buildMessageList(chatState)
                    : _buildEmptyState(),
              ),
              // Quick actions
              if (chatState.quickActions.isNotEmpty && !chatState.isTyping)
                _buildQuickActions(chatState.quickActions, controller),
              // Input field
              ChatInputField(
                onSend: (message) => controller.sendMessage(message),
                enabled: !chatState.isTyping,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(ChatController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // AI icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade700.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.auto_awesome,
              color: Colors.green.shade400,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Assistant',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Poker strategy advisor',
                  style: GoogleFonts.roboto(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Clear history button
          IconButton(
            onPressed: controller.clearHistory,
            icon: const Icon(Icons.delete_outline),
            color: Colors.white54,
            tooltip: 'Clear chat',
          ),
          // Close button
          IconButton(
            onPressed: controller.closeChat,
            icon: const Icon(Icons.close),
            color: Colors.white54,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _buildContextBar(GameContextSnapshot context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF263238), // blueGrey.shade900
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.casino, color: Colors.blue.shade300, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.summary,
              style: GoogleFonts.roboto(color: Colors.white70, fontSize: 12),
            ),
          ),
          if (context.heroEquity != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getEquityColor(
                  context.heroEquity!,
                ).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${context.heroEquity!.toStringAsFixed(1)}%',
                style: GoogleFonts.robotoMono(
                  color: _getEquityColor(context.heroEquity!),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getEquityColor(double equity) {
    if (equity >= 60) return Colors.lightGreenAccent;
    if (equity >= 40) return Colors.amber;
    return Colors.redAccent;
  }

  Widget _buildMessageList(ChatState chatState) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount:
          chatState.messages.length +
          (chatState.isTyping ? 1 : 0) +
          (chatState.streamingContent.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        // Streaming content
        if (chatState.streamingContent.isNotEmpty &&
            index == chatState.messages.length) {
          return StreamingBubble(content: chatState.streamingContent);
        }

        // Typing indicator
        if (chatState.isTyping &&
            chatState.streamingContent.isEmpty &&
            index == chatState.messages.length) {
          return const TypingIndicator();
        }

        // Regular message
        if (index < chatState.messages.length) {
          final message = chatState.messages[index];
          return MessageBubble(message: message);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 64,
            color: Colors.green.shade700.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'AI Poker Assistant',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ask me about your hand,\npot odds, or strategy',
            style: GoogleFonts.roboto(color: Colors.white54, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
    List<QuickAction> actions,
    ChatController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: actions.map((action) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _QuickActionChip(
                action: action,
                onTap: () => controller.sendQuickAction(action),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Quick action chip widget
class _QuickActionChip extends StatelessWidget {
  final QuickAction action;
  final VoidCallback onTap;

  const _QuickActionChip({required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF78909C).withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIconData(action.icon),
                color: Colors.green.shade300,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                action.label,
                style: GoogleFonts.roboto(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String? icon) {
    return switch (icon) {
      'help' => Icons.help_outline,
      'cards' => Icons.style,
      'position' => Icons.event_seat,
      'percent' => Icons.percent,
      'analytics' => Icons.analytics,
      'draw' => Icons.trending_up,
      'call' => Icons.call_made,
      'odds' => Icons.calculate,
      'bet' => Icons.attach_money,
      _ => Icons.lightbulb_outline,
    };
  }
}

/// Shows the chat bottom sheet as a modal
Future<void> showChatBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const ChatBottomSheet(),
  );
}
