import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/chat_message.dart';
import 'poker_content_renderer.dart';

/// Message bubble widget for chat messages
class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showTimestamp;

  const MessageBubble({
    super.key,
    required this.message,
    this.showTimestamp = true,
  });

  @override
  Widget build(BuildContext context) {
    return switch (message.sender) {
      MessageSender.user => _UserBubble(
        message: message,
        showTimestamp: showTimestamp,
      ),
      MessageSender.ai => _AiBubble(
        message: message,
        showTimestamp: showTimestamp,
      ),
      MessageSender.system => _SystemBubble(message: message),
    };
  }
}

/// User message bubble (right-aligned, blue)
class _UserBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showTimestamp;

  const _UserBubble({required this.message, this.showTimestamp = true});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
          padding: const EdgeInsets.only(
            left: 48,
            right: 12,
            top: 4,
            bottom: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.78),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0), // blue.shade800
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(4), // Tail effect
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  message.content,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              if (showTimestamp)
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 4),
                  child: Text(
                    message.formattedTime,
                    style: GoogleFonts.roboto(
                      color: Colors.white30,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 200))
        .slideX(
          begin: 0.2,
          end: 0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
        );
  }
}

/// AI message bubble (left-aligned, grey with avatar)
class _AiBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showTimestamp;

  const _AiBubble({required this.message, this.showTimestamp = true});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 48,
            top: 4,
            bottom: 4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI Avatar
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32), // green.shade700
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              // Message content
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: screenWidth * 0.72),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF424242), // grey.shade800
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4), // Tail effect
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _buildMessageContent(),
                    ),
                    if (showTimestamp)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          message.formattedTime,
                          style: GoogleFonts.roboto(
                            color: Colors.white30,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 200))
        .slideX(
          begin: -0.2,
          end: 0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildMessageContent() {
    // Parse content for special formatting
    final content = message.content;

    // Check if content has bullet points
    if (content.contains('•') || content.contains('\n\n')) {
      return _FormattedContent(content: content);
    }

    // Use PokerContentRenderer for inline card rendering
    return PokerContentRenderer(
      content: content,
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}

/// Formatted content with bullet points and sections
class _FormattedContent extends StatelessWidget {
  final String content;

  const _FormattedContent({required this.content});

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      if (line.startsWith('•')) {
        // Bullet point
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: GoogleFonts.roboto(
                    color: Colors.green.shade300,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PokerContentRenderer(
                    content: line.substring(1).trim(),
                    textColor: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        // Regular text
        widgets.add(
          Padding(
            padding: EdgeInsets.only(
              top: i > 0 && lines[i - 1].trim().isEmpty ? 8 : 2,
              bottom: 2,
            ),
            child: PokerContentRenderer(
              content: line,
              textColor: Colors.white,
              fontSize: 14,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

/// System message bubble (centered, subtle)
class _SystemBubble extends StatelessWidget {
  final ChatMessage message;

  const _SystemBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white.withValues(alpha: 0.5),
              size: 14,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message.content,
                style: GoogleFonts.roboto(color: Colors.white60, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 300));
  }
}

/// Typing indicator (three bouncing dots)
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 48, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          // Typing dots
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF424242),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 4),
                  child: _BouncingDot(
                    delay: Duration(milliseconds: index * 150),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/// Single bouncing dot for typing indicator
class _BouncingDot extends StatefulWidget {
  final Duration delay;

  const _BouncingDot({required this.delay});

  @override
  State<_BouncingDot> createState() => _BouncingDotState();
}

class _BouncingDotState extends State<_BouncingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: -6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

/// Streaming message bubble (for partial AI responses)
class StreamingBubble extends StatelessWidget {
  final String content;

  const StreamingBubble({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 48, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          // Streaming content
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: screenWidth * 0.72),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF424242),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      content,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Cursor blink
                  _BlinkingCursor(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Blinking cursor for streaming text
class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: 16,
        decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
