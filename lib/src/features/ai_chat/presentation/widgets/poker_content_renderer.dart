import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget to render poker-specific content in messages
/// Supports inline card display (A♠ K♥), equity badges, and formatted text
class PokerContentRenderer extends StatelessWidget {
  final String content;
  final Color textColor;
  final double fontSize;

  const PokerContentRenderer({
    super.key,
    required this.content,
    this.textColor = Colors.white,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _parseContent(content),
        style: GoogleFonts.roboto(
          color: textColor,
          fontSize: fontSize,
          height: 1.4,
        ),
      ),
    );
  }

  /// Parse content and return styled spans
  List<InlineSpan> _parseContent(String text) {
    final spans = <InlineSpan>[];

    // Regex patterns
    final cardPattern = RegExp(r'([AKQJT2-9])([♠♥♦♣]|[shdc])');
    final equityPattern = RegExp(r'(\d{1,3}(?:\.\d)?)\s*%');
    final boldPattern = RegExp(r'\*\*([^*]+)\*\*');

    int lastEnd = 0;

    // Find all special patterns
    final matches = <_MatchInfo>[];

    for (final match in cardPattern.allMatches(text)) {
      matches.add(_MatchInfo(match.start, match.end, 'card', match.group(0)!));
    }

    for (final match in equityPattern.allMatches(text)) {
      matches.add(
        _MatchInfo(match.start, match.end, 'equity', match.group(0)!),
      );
    }

    for (final match in boldPattern.allMatches(text)) {
      matches.add(_MatchInfo(match.start, match.end, 'bold', match.group(1)!));
    }

    // Sort matches by position
    matches.sort((a, b) => a.start.compareTo(b.start));

    // Remove overlapping matches
    final filteredMatches = <_MatchInfo>[];
    int lastMatchEnd = 0;
    for (final match in matches) {
      if (match.start >= lastMatchEnd) {
        filteredMatches.add(match);
        lastMatchEnd = match.end;
      }
    }

    // Build spans
    for (final match in filteredMatches) {
      // Add text before match
      if (match.start > lastEnd) {
        final plainText = text.substring(lastEnd, match.start);
        spans.add(TextSpan(text: plainText));
      }

      // Add styled content
      switch (match.type) {
        case 'card':
          spans.add(_buildCardSpan(match.content));
          break;
        case 'equity':
          spans.add(_buildEquitySpan(match.content));
          break;
        case 'bold':
          spans.add(_buildBoldSpan(match.content));
          break;
      }

      lastEnd = match.end;
    }

    // Add remaining text
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return spans;
  }

  /// Build inline card span with colored suit
  InlineSpan _buildCardSpan(String card) {
    if (card.length < 2) return TextSpan(text: card);

    final rank = card[0];
    var suit = card.substring(1);

    // Convert letter suits to symbols
    suit = switch (suit.toLowerCase()) {
      's' => '♠',
      'h' => '♥',
      'd' => '♦',
      'c' => '♣',
      _ => suit,
    };

    final isRed = suit == '♥' || suit == '♦';
    final suitColor = isRed ? Colors.red.shade400 : Colors.white;

    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade600, width: 0.5),
        ),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: rank,
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: fontSize - 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: suit,
                style: GoogleFonts.robotoMono(
                  color: suitColor,
                  fontSize: fontSize - 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build equity badge span
  InlineSpan _buildEquitySpan(String equity) {
    // Extract numeric value
    final numMatch = RegExp(r'(\d+(?:\.\d)?)').firstMatch(equity);
    if (numMatch == null) return TextSpan(text: equity);

    final value = double.tryParse(numMatch.group(1)!) ?? 0;

    // Determine color based on equity value
    Color badgeColor;
    if (value >= 60) {
      badgeColor = Colors.green.shade400;
    } else if (value >= 40) {
      badgeColor = Colors.amber.shade400;
    } else {
      badgeColor = Colors.red.shade400;
    }

    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: badgeColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
        ),
        child: Text(
          equity,
          style: GoogleFonts.robotoMono(
            color: badgeColor,
            fontSize: fontSize - 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Build bold text span
  InlineSpan _buildBoldSpan(String content) {
    return TextSpan(
      text: content,
      style: GoogleFonts.roboto(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// Helper class for match info
class _MatchInfo {
  final int start;
  final int end;
  final String type;
  final String content;

  _MatchInfo(this.start, this.end, this.type, this.content);
}

/// Inline card widget for use in other contexts
class InlineCard extends StatelessWidget {
  final String rank;
  final String suit;
  final double size;

  const InlineCard({
    super.key,
    required this.rank,
    required this.suit,
    this.size = 14,
  });

  factory InlineCard.fromString(String card) {
    if (card.length < 2) {
      return const InlineCard(rank: '?', suit: '?');
    }
    return InlineCard(rank: card[0], suit: card.substring(1));
  }

  @override
  Widget build(BuildContext context) {
    var displaySuit = suit;

    // Convert letter suits to symbols
    displaySuit = switch (suit.toLowerCase()) {
      's' => '♠',
      'h' => '♥',
      'd' => '♦',
      'c' => '♣',
      _ => suit,
    };

    final isRed = displaySuit == '♥' || displaySuit == '♦';
    final suitColor = isRed ? Colors.red.shade400 : Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade600, width: 0.5),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: rank,
              style: GoogleFonts.robotoMono(
                color: Colors.white,
                fontSize: size,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: displaySuit,
              style: GoogleFonts.robotoMono(
                color: suitColor,
                fontSize: size,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Row of inline cards
class InlineCardRow extends StatelessWidget {
  final List<String> cards;
  final double size;
  final double spacing;

  const InlineCardRow({
    super.key,
    required this.cards,
    this.size = 14,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: cards.map((card) {
        return Padding(
          padding: EdgeInsets.only(right: spacing),
          child: InlineCard.fromString(card),
        );
      }).toList(),
    );
  }
}

/// Equity badge widget
class EquityBadge extends StatelessWidget {
  final double equity;
  final double fontSize;

  const EquityBadge({super.key, required this.equity, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    if (equity >= 60) {
      badgeColor = Colors.green.shade400;
    } else if (equity >= 40) {
      badgeColor = Colors.amber.shade400;
    } else {
      badgeColor = Colors.red.shade400;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
      ),
      child: Text(
        '${equity.toStringAsFixed(1)}%',
        style: GoogleFonts.robotoMono(
          color: badgeColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
