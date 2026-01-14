import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokerRulesScreen extends StatelessWidget {
  const PokerRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          'Poker Rules',
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
            // Introduction Card
            _buildIntroCard(),
            const SizedBox(height: 24),

            // Game Flow Section
            _buildSection('Game Flow', Icons.loop, Colors.blue, [
              _buildNumberedStep(
                1,
                'Blinds',
                'Small Blind (SB) and Big Blind (BB) post forced bets. '
                    'SB is half of BB. This creates initial action.',
                Colors.blue,
              ),
              _buildNumberedStep(
                2,
                'Hole Cards',
                'Each player receives 2 private cards (hole cards). '
                    'Only you can see your cards.',
                Colors.blue,
              ),
              _buildNumberedStep(
                3,
                'Preflop Betting',
                'First betting round starts with player left of BB. '
                    'Options: Fold, Call, or Raise.',
                Colors.blue,
              ),
              _buildNumberedStep(
                4,
                'The Flop',
                '3 community cards are dealt face up. '
                    'Second betting round begins with first active player left of button.',
                Colors.blue,
              ),
              _buildNumberedStep(
                5,
                'The Turn',
                '4th community card is dealt. '
                    'Third betting round with same rules.',
                Colors.blue,
              ),
              _buildNumberedStep(
                6,
                'The River',
                '5th and final community card is dealt. '
                    'Final betting round.',
                Colors.blue,
              ),
              _buildNumberedStep(
                7,
                'Showdown',
                'Remaining players show their hands. '
                    'Best 5-card hand wins the pot.',
                Colors.blue,
              ),
            ]),
            const SizedBox(height: 24),

            // Betting Actions Section
            _buildSection('Betting Actions', Icons.monetization_on, Colors.green, [
              _buildActionItem(
                'Fold',
                'Give up your hand and any bets you\'ve made. '
                    'You\'re out of the current hand.',
                Icons.cancel_outlined,
                Colors.red,
              ),
              _buildActionItem(
                'Check',
                'Pass the action without betting (only if no one has bet). '
                    'Stay in the hand for free.',
                Icons.check_circle_outline,
                Colors.grey,
              ),
              _buildActionItem(
                'Call',
                'Match the current bet amount to stay in the hand. '
                    'You commit more chips to the pot.',
                Icons.call_received,
                Colors.blue,
              ),
              _buildActionItem(
                'Bet',
                'Put chips into the pot when no one has bet yet. '
                    'Others must call, raise, or fold.',
                Icons.attach_money,
                Colors.green,
              ),
              _buildActionItem(
                'Raise',
                'Increase the current bet. Must be at least the size of the previous bet/raise. '
                    'Forces others to commit more chips.',
                Icons.trending_up,
                Colors.orange,
              ),
              _buildActionItem(
                'All-In',
                'Bet all your remaining chips. '
                    'You can still win the portion of pot you contributed to.',
                Icons.local_fire_department,
                Colors.red,
              ),
            ]),
            const SizedBox(height: 24),

            // Hand Rankings Section
            _buildSection(
              'Hand Rankings (Highest to Lowest)',
              Icons.emoji_events,
              Colors.amber,
              [
                _buildHandRankItem(
                  1,
                  'Royal Flush',
                  'A, K, Q, J, 10 of the same suit',
                  'A♠ K♠ Q♠ J♠ 10♠',
                  Colors.purple,
                ),
                _buildHandRankItem(
                  2,
                  'Straight Flush',
                  'Five consecutive cards of the same suit',
                  '9♥ 8♥ 7♥ 6♥ 5♥',
                  Colors.purple,
                ),
                _buildHandRankItem(
                  3,
                  'Four of a Kind',
                  'Four cards of the same rank',
                  'K♠ K♥ K♦ K♣ 7♠',
                  Colors.red,
                ),
                _buildHandRankItem(
                  4,
                  'Full House',
                  'Three of a kind plus a pair',
                  'Q♠ Q♥ Q♦ 9♠ 9♥',
                  Colors.red,
                ),
                _buildHandRankItem(
                  5,
                  'Flush',
                  'Five cards of the same suit',
                  'A♦ J♦ 8♦ 6♦ 3♦',
                  Colors.blue,
                ),
                _buildHandRankItem(
                  6,
                  'Straight',
                  'Five consecutive cards of mixed suits',
                  '10♠ 9♥ 8♦ 7♣ 6♠',
                  Colors.blue,
                ),
                _buildHandRankItem(
                  7,
                  'Three of a Kind',
                  'Three cards of the same rank',
                  '7♠ 7♥ 7♦ K♠ 2♣',
                  Colors.green,
                ),
                _buildHandRankItem(
                  8,
                  'Two Pair',
                  'Two different pairs',
                  'J♠ J♥ 5♦ 5♣ A♠',
                  Colors.green,
                ),
                _buildHandRankItem(
                  9,
                  'One Pair',
                  'Two cards of the same rank',
                  '10♠ 10♥ A♦ 8♣ 4♠',
                  Colors.orange,
                ),
                _buildHandRankItem(
                  10,
                  'High Card',
                  'No matching cards; highest card plays',
                  'A♠ J♥ 8♦ 5♣ 2♠',
                  Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Positions Section
            _buildSection('Table Positions', Icons.event_seat, Colors.teal, [
              _buildPositionItem(
                'Button (BTN)',
                'Best position. Acts last in all post-flop betting rounds. '
                    'Most information advantage.',
                Colors.green,
              ),
              _buildPositionItem(
                'Small Blind (SB)',
                'Posts small forced bet. Acts first post-flop. '
                    'Worst position - must act first with limited info.',
                Colors.red,
              ),
              _buildPositionItem(
                'Big Blind (BB)',
                'Posts big forced bet. Acts second post-flop. '
                    'Gets to see all action preflop before deciding.',
                Colors.orange,
              ),
              _buildPositionItem(
                'Under the Gun (UTG)',
                'First to act preflop. Very difficult position. '
                    'Play only strong hands here.',
                Colors.red,
              ),
              _buildPositionItem(
                'Middle Position (MP)',
                'Between early and late positions. '
                    'Can widen range slightly from UTG.',
                Colors.orange,
              ),
              _buildPositionItem(
                'Cutoff (CO)',
                'Second best position, right before the button. '
                    'Can play wider range of hands.',
                Colors.green,
              ),
            ]),
            const SizedBox(height: 24),

            // Key Concepts Section
            _buildSection('Key Concepts', Icons.lightbulb, Colors.yellow, [
              _buildConceptItem(
                'Pot Odds',
                'The ratio of the current pot size to the cost of calling. '
                    'If pot is \$100 and call is \$20, pot odds are 5:1.',
                Icons.calculate,
              ),
              _buildConceptItem(
                'Equity',
                'Your percentage chance of winning the pot. '
                    'Compare equity to pot odds for profitable decisions.',
                Icons.pie_chart,
              ),
              _buildConceptItem(
                'Position',
                'Acting last gives you more information. '
                    'Play more hands in late position, fewer in early.',
                Icons.event_seat,
              ),
              _buildConceptItem(
                'Implied Odds',
                'Potential future winnings if you hit your hand. '
                    'Call with drawing hands if implied odds are good.',
                Icons.trending_up,
              ),
              _buildConceptItem(
                'Bluffing',
                'Betting with a weak hand to make opponents fold better hands. '
                    'Use sparingly and in the right spots.',
                Icons.psychology,
              ),
              _buildConceptItem(
                'Value Betting',
                'Betting with a strong hand to get called by worse hands. '
                    'Size your bets to maximize value.',
                Icons.attach_money,
              ),
            ]),
            const SizedBox(height: 24),

            // Important Rules Section
            _buildSection('Important Rules', Icons.rule, Colors.red, [
              _buildRuleItem(
                'One Player Per Hand',
                'Discussing your hand with others during play is not allowed.',
              ),
              _buildRuleItem(
                'Cards Speak',
                'The best hand wins regardless of verbal declarations.',
              ),
              _buildRuleItem(
                'String Betting',
                'You cannot go back for more chips once you start betting. '
                    'Announce your raise first or put all chips in at once.',
              ),
              _buildRuleItem(
                'Protecting Your Cards',
                'You\'re responsible for protecting your hand. '
                    'Use a card protector or keep hands on cards.',
              ),
              _buildRuleItem(
                'Acting in Turn',
                'Wait for your turn to act. Acting out of turn can give '
                    'unfair information to other players.',
              ),
              _buildRuleItem(
                'Minimum Raise',
                'A raise must be at least the size of the previous bet or raise. '
                    'All-in for less doesn\'t reopen betting.',
              ),
            ]),
            const SizedBox(height: 32),

            // Pro Tips Card
            _buildProTipsCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade900, Colors.green.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.casino, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Texas Hold\'em',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'The World\'s Most Popular Poker Game',
                      style: GoogleFonts.roboto(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Each player receives 2 hole cards, and 5 community cards are dealt. '
            'Make the best 5-card hand using any combination of your hole cards '
            'and the community cards.',
            style: GoogleFonts.roboto(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
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
        ...children,
      ],
    );
  }

  Widget _buildNumberedStep(
    int number,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: GoogleFonts.roboto(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandRankItem(
    int rank,
    String name,
    String description,
    String example,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.3),
                  color.withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: GoogleFonts.robotoMono(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              example,
              style: GoogleFonts.robotoMono(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionItem(String title, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConceptItem(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.yellow.shade600, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.gavel, color: Colors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProTipsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade900, Colors.orange.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stars, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                'Pro Tips',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProTip('Start tight, loosen up as you gain experience'),
          _buildProTip('Position is power - play more hands in late position'),
          _buildProTip('Pay attention to your opponents\' betting patterns'),
          _buildProTip(
            'Manage your bankroll - never risk more than you can afford',
          ),
          _buildProTip('Use this calculator to practice calculating pot odds'),
        ],
      ),
    );
  }

  Widget _buildProTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.roboto(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
