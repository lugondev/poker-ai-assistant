import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          'Help & Guide',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Getting Started',
              Icons.play_circle_outline,
              Colors.green,
              [
                _HelpItem(
                  'Setting Up Your Hand',
                  'Tap on the card slots to select your hole cards. '
                      'Use the card picker at the bottom to choose cards.',
                ),
                _HelpItem(
                  'Adding Opponents',
                  'Tap "+ Player" to add opponents. You can add up to 9 players total.',
                ),
                _HelpItem(
                  'Board Cards',
                  'Use the phase tabs (Preflop, Flop, Turn, River) to set community cards.',
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Understanding Equity',
              Icons.analytics_outlined,
              Colors.blue,
              [
                _HelpItem(
                  'What is Equity?',
                  'Equity represents your share of the pot based on your probability of winning. '
                      'If you have 60% equity, you expect to win 60% of the pot on average.',
                ),
                _HelpItem(
                  'Win vs Tie',
                  'Win percentage shows how often you win outright. '
                      'Tie percentage shows how often you split the pot.',
                ),
                _HelpItem(
                  'Pot Odds',
                  'Pot odds tell you how much you need to call relative to the pot size. '
                      'If pot odds are 3:1, you\'re risking 1 to win 3.',
                ),
                _HelpItem(
                  'Required Equity',
                  'This shows the minimum equity you need to profitably call. '
                      'If your equity exceeds this, calling is profitable long-term.',
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection('Using Ranges', Icons.grid_view, Colors.purple, [
              _HelpItem(
                'What are Ranges?',
                'A range is a collection of hands an opponent might have. '
                    'Instead of assigning specific cards, you can assign a range of likely hands.',
              ),
              _HelpItem(
                'Selecting Ranges',
                'Tap "Range" on an opponent to open the range selector. '
                    'Tap individual hands or use preset ranges.',
              ),
              _HelpItem(
                'Range Notation',
                'Hands are shown as: AA (pocket aces), AKs (suited), AKo (offsuit). '
                    'The grid shows all 169 possible starting hands.',
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('AI Assistant', Icons.smart_toy, Colors.amber, [
              _HelpItem(
                'Getting Advice',
                'Tap the AI chat button to open the assistant. '
                    'Ask questions about your current hand or general poker strategy.',
              ),
              _HelpItem(
                'Context-Aware',
                'The AI can see your current hand setup and provides relevant advice. '
                    'Use quick actions for common questions.',
              ),
              _HelpItem(
                'API Configuration',
                'Configure your preferred AI provider in Settings > AI Settings. '
                    'You can use OpenAI, Anthropic, Gemini, and more.',
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('Poker Tips', Icons.lightbulb_outline, Colors.orange, [
              _HelpItem(
                'Position Matters',
                'Playing in position (acting last) gives you more information. '
                    'Play tighter from early position, looser from the button.',
              ),
              _HelpItem(
                'Pot Odds Decision',
                'Compare your equity to pot odds. If your equity is higher than '
                    'the required equity to call, it\'s a profitable call.',
              ),
              _HelpItem(
                'Hand Selection',
                'Premium hands (AA, KK, QQ, AK) should be played aggressively. '
                    'Speculative hands need good implied odds.',
              ),
              _HelpItem(
                'Bet Sizing',
                'Standard bet sizes: 50-75% pot for value, similar for bluffs. '
                    'Larger on wet boards, smaller on dry boards.',
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('Hand Rankings', Icons.emoji_events, Colors.cyan, [
              _HelpItem(
                'Royal Flush',
                'A, K, Q, J, 10 all of the same suit. The best possible hand.',
              ),
              _HelpItem(
                'Straight Flush',
                'Five consecutive cards of the same suit.',
              ),
              _HelpItem(
                'Four of a Kind',
                'Four cards of the same rank (e.g., four Kings).',
              ),
              _HelpItem(
                'Full House',
                'Three of a kind plus a pair (e.g., three 8s and two 4s).',
              ),
              _HelpItem(
                'Flush',
                'Five cards of the same suit, not in sequence.',
              ),
              _HelpItem('Straight', 'Five consecutive cards of mixed suits.'),
              _HelpItem('Three of a Kind', 'Three cards of the same rank.'),
              _HelpItem(
                'Two Pair',
                'Two different pairs (e.g., two Jacks and two 7s).',
              ),
              _HelpItem('One Pair', 'Two cards of the same rank.'),
              _HelpItem('High Card', 'No matching cards; highest card plays.'),
            ]),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    IconData icon,
    Color color,
    List<_HelpItem> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...items.map((item) => _buildHelpItem(item)),
      ],
    );
  }

  Widget _buildHelpItem(_HelpItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpItem {
  final String title;
  final String description;

  _HelpItem(this.title, this.description);
}
