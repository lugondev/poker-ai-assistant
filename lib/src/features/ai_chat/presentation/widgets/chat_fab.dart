import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/chat_controller.dart';

/// Floating Action Button for AI Chat
class ChatFAB extends ConsumerWidget {
  const ChatFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatControllerProvider);
    final hasUnread = chatState.hasUnread;
    final unreadCount = chatState.unreadCount;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main FAB
        _buildFAB(ref, chatState.isOpen, hasUnread),

        // Unread badge
        if (hasUnread)
          Positioned(right: -4, top: -4, child: _buildBadge(unreadCount)),
      ],
    );
  }

  Widget _buildFAB(WidgetRef ref, bool isOpen, bool hasUnread) {
    Widget fab = FloatingActionButton(
      onPressed: () => ref.read(chatControllerProvider.notifier).toggleChat(),
      backgroundColor: const Color(0xFF2E7D32), // green.shade700
      foregroundColor: Colors.white,
      elevation: 4,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isOpen
            ? const Icon(Icons.close, key: ValueKey('close'))
            : const Icon(Icons.auto_awesome, key: ValueKey('ai')),
      ),
    );

    // Add pulse animation when has unread messages
    if (hasUnread) {
      fab = fab
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scaleXY(
            begin: 1.0,
            end: 1.08,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
    }

    return fab;
  }

  Widget _buildBadge(int unreadCount) {
    return Container(
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF1A1A2E), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade600.withValues(alpha: 0.5),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          unreadCount > 9 ? '9+' : unreadCount.toString(),
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).animate().scaleXY(
      begin: 0,
      end: 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.elasticOut,
    );
  }
}

/// Mini FAB variant for smaller spaces
class ChatMiniFAB extends ConsumerWidget {
  const ChatMiniFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatControllerProvider);
    final hasUnread = chatState.hasUnread;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        FloatingActionButton.small(
          onPressed: () =>
              ref.read(chatControllerProvider.notifier).toggleChat(),
          backgroundColor: const Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          child: const Icon(Icons.auto_awesome, size: 20),
        ),
        if (hasUnread)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1A1A2E), width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
