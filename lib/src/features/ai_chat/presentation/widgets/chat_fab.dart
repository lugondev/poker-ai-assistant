import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/chat_controller.dart';

/// Floating Action Button for AI Chat with drag-to-move functionality
class ChatFAB extends ConsumerStatefulWidget {
  const ChatFAB({super.key});

  @override
  ConsumerState<ChatFAB> createState() => _ChatFABState();
}

class _ChatFABState extends ConsumerState<ChatFAB> {
  bool _isDragging = false;

  // FAB size for boundary calculations
  static const double _fabSize = 56.0;
  static const double _padding = 16.0;

  Offset _getDefaultPosition(Size screenSize) {
    return Offset(
      screenSize.width - _fabSize - _padding,
      screenSize.height - _fabSize - _padding - 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final hasUnread = chatState.hasUnread;
    final unreadCount = chatState.unreadCount;
    final screenSize = MediaQuery.of(context).size;

    // Get position from provider or use default
    final currentPosition =
        chatState.fabPosition ?? _getDefaultPosition(screenSize);

    return Positioned(
      left: currentPosition.dx,
      top: currentPosition.dy,
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: (details) => _onPanUpdate(details, screenSize),
        onPanEnd: (details) => _onPanEnd(details, screenSize),
        child: AnimatedScale(
          scale: _isDragging ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _isDragging
                      ? Colors.green.withValues(alpha: 0.5)
                      : Colors.black.withValues(alpha: 0.3),
                  blurRadius: _isDragging ? 16 : 8,
                  spreadRadius: _isDragging ? 2 : 0,
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main FAB
                _buildFAB(ref, chatState.isOpen, hasUnread),

                // Unread badge
                if (hasUnread)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: _buildBadge(unreadCount),
                  ),

                // Drag indicator (shows when dragging)
                if (_isDragging)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
    HapticFeedback.lightImpact();
  }

  void _onPanUpdate(DragUpdateDetails details, Size screenSize) {
    final chatState = ref.read(chatControllerProvider);
    final currentPos = chatState.fabPosition ?? _getDefaultPosition(screenSize);

    // Calculate new position
    double newX = currentPos.dx + details.delta.dx;
    double newY = currentPos.dy + details.delta.dy;

    // Clamp to screen boundaries
    newX = newX.clamp(_padding, screenSize.width - _fabSize - _padding);
    newY = newY.clamp(
      _padding + 50,
      screenSize.height - _fabSize - _padding - 50,
    );

    // Update position in provider
    ref
        .read(chatControllerProvider.notifier)
        .updateFabPosition(Offset(newX, newY));
  }

  void _onPanEnd(DragEndDetails details, Size screenSize) {
    final chatState = ref.read(chatControllerProvider);
    final position = chatState.fabPosition;

    // Snap to nearest edge (left or right)
    if (position != null) {
      final centerX = position.dx + _fabSize / 2;
      final screenCenterX = screenSize.width / 2;

      double targetX;
      if (centerX < screenCenterX) {
        // Snap to left
        targetX = _padding;
      } else {
        // Snap to right
        targetX = screenSize.width - _fabSize - _padding;
      }

      ref
          .read(chatControllerProvider.notifier)
          .updateFabPosition(Offset(targetX, position.dy));

      HapticFeedback.mediumImpact();
    }

    setState(() {
      _isDragging = false;
    });
  }

  Widget _buildFAB(WidgetRef ref, bool isOpen, bool hasUnread) {
    Widget fab = Material(
      elevation: 0,
      shape: const CircleBorder(),
      color: const Color(0xFF2E7D32),
      child: InkWell(
        onTap: _isDragging
            ? null
            : () => ref.read(chatControllerProvider.notifier).toggleChat(),
        customBorder: const CircleBorder(),
        splashColor: Colors.white.withValues(alpha: 0.2),
        highlightColor: Colors.white.withValues(alpha: 0.1),
        child: SizedBox(
          width: _fabSize,
          height: _fabSize,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isOpen
                  ? const Icon(
                      Icons.close,
                      key: ValueKey('close'),
                      color: Colors.white,
                      size: 24,
                    )
                  : const Icon(
                      Icons.auto_awesome,
                      key: ValueKey('ai'),
                      color: Colors.white,
                      size: 24,
                    ),
            ),
          ),
        ),
      ),
    );

    // Add pulse animation when has unread messages
    if (hasUnread && !_isDragging) {
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
