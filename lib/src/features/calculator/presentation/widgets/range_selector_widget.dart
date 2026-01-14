import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Represents a hand combination in the range grid
class HandCombination {
  final String display;
  final int row;
  final int col;
  final bool isPair;
  final bool isSuited;

  const HandCombination({
    required this.display,
    required this.row,
    required this.col,
    required this.isPair,
    required this.isSuited,
  });

  bool get isOffsuit => !isPair && !isSuited;
}

/// Predefined hand range presets
enum RangePreset {
  none('None', 0),
  top5('Top 5%', 5),
  top10('Top 10%', 10),
  top15('Top 15%', 15),
  top20('Top 20%', 20),
  top25('Top 25%', 25),
  top30('Top 30%', 30),
  top50('Top 50%', 50),
  allPairs('All Pairs', -1),
  allBroadway('Broadway', -2),
  random('Random', 100);

  final String displayName;
  final int percentage;
  const RangePreset(this.displayName, this.percentage);
}

/// Widget for selecting poker hand ranges
class RangeSelectorWidget extends StatefulWidget {
  final Set<String> initialSelectedHands;
  final void Function(Set<String> selectedHands) onRangeSelected;
  final VoidCallback? onCancel;

  const RangeSelectorWidget({
    super.key,
    this.initialSelectedHands = const {},
    required this.onRangeSelected,
    this.onCancel,
  });

  @override
  State<RangeSelectorWidget> createState() => _RangeSelectorWidgetState();
}

class _RangeSelectorWidgetState extends State<RangeSelectorWidget> {
  late Set<String> _selectedHands;
  RangePreset _currentPreset = RangePreset.none;

  // Card ranks from high to low
  static const _ranks = [
    'A',
    'K',
    'Q',
    'J',
    'T',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2',
  ];

  // Top hands by equity (ordered)
  static const _topHandsOrder = [
    'AA',
    'KK',
    'QQ',
    'AKs',
    'JJ',
    'AQs',
    'KQs',
    'AJs',
    'KJs',
    'TT',
    'AKo',
    'ATs',
    'QJs',
    'KTs',
    'QTs',
    '99',
    'JTs',
    'AQo',
    'A9s',
    'KQo',
    'A8s',
    'K9s',
    'T9s',
    'A5s',
    'A7s',
    '88',
    'KJo',
    'QJo',
    'A4s',
    'A6s',
    'Q9s',
    'A3s',
    'J9s',
    'K8s',
    'A2s',
    'T8s',
    'K7s',
    '77',
    'KTo',
    'Q8s',
    'K6s',
    'QTo',
    'J8s',
    '98s',
    'K5s',
    'JTo',
    'K4s',
    'K3s',
    'K2s',
    '66',
    'Q7s',
    'AJo',
    'T7s',
    '87s',
    'Q6s',
    'Q5s',
    '97s',
    'J7s',
    'A9o',
    '55',
    'Q4s',
    'Q3s',
    'Q2s',
    'T9o',
    '86s',
    '76s',
    'J6s',
    'J5s',
    '96s',
    'A8o',
    'J4s',
    'J3s',
    'J2s',
    '44',
    '65s',
    'T6s',
    '54s',
    '75s',
    '98o',
    'A7o',
    '85s',
    'T5s',
    'T4s',
    'T3s',
    '33',
    'A5o',
    '64s',
    '74s',
    'K9o',
    'A6o',
    'T2s',
    '53s',
    'A4o',
    '87o',
    '22',
    'Q9o',
    '95s',
    '94s',
    '93s',
    '92s',
    '84s',
    'A3o',
    'J9o',
    '43s',
    '63s',
    '73s',
    'A2o',
    'K8o',
    '76o',
    'T8o',
    '83s',
    '82s',
    '52s',
    '42s',
    '97o',
    'K7o',
    '65o',
    '54o',
    '86o',
    '32s',
    'Q8o',
    'K6o',
    '72s',
    '96o',
    'J8o',
    'K5o',
    '62s',
    '75o',
    'K4o',
    'K3o',
    'K2o',
    '85o',
    'Q7o',
    '64o',
    'T7o',
    'Q6o',
    '74o',
    'Q5o',
    'J7o',
    '53o',
    'Q4o',
    '95o',
    'Q3o',
    '43o',
    'Q2o',
    'J6o',
    '63o',
    'T6o',
    '84o',
    'J5o',
    '94o',
    '73o',
    'J4o',
    '52o',
    'J3o',
    'J2o',
    '42o',
    'T5o',
    '93o',
    '32o',
    'T4o',
    '83o',
    'T3o',
    '62o',
    'T2o',
    '92o',
    '82o',
    '72o',
  ];

  // Broadway hands (T or higher)
  static const _broadwayHands = [
    'AA',
    'AKs',
    'AQs',
    'AJs',
    'ATs',
    'AKo',
    'AQo',
    'AJo',
    'ATo',
    'KK',
    'KQs',
    'KJs',
    'KTs',
    'KQo',
    'KJo',
    'KTo',
    'QQ',
    'QJs',
    'QTs',
    'QJo',
    'QTo',
    'JJ',
    'JTs',
    'JTo',
    'TT',
  ];

  // All pairs
  static const _allPairs = [
    'AA',
    'KK',
    'QQ',
    'JJ',
    'TT',
    '99',
    '88',
    '77',
    '66',
    '55',
    '44',
    '33',
    '22',
  ];

  @override
  void initState() {
    super.initState();
    _selectedHands = Set.from(widget.initialSelectedHands);
  }

  List<HandCombination> _generateHandGrid() {
    final hands = <HandCombination>[];

    for (int row = 0; row < 13; row++) {
      for (int col = 0; col < 13; col++) {
        final rank1 = _ranks[row];
        final rank2 = _ranks[col];

        String display;
        bool isPair = false;
        bool isSuited = false;

        if (row == col) {
          // Pair (diagonal)
          display = '$rank1$rank2';
          isPair = true;
        } else if (row < col) {
          // Suited (above diagonal)
          display = '$rank1${rank2}s';
          isSuited = true;
        } else {
          // Offsuit (below diagonal)
          display = '$rank2${rank1}o';
        }

        hands.add(
          HandCombination(
            display: display,
            row: row,
            col: col,
            isPair: isPair,
            isSuited: isSuited,
          ),
        );
      }
    }

    return hands;
  }

  void _toggleHand(String hand) {
    setState(() {
      if (_selectedHands.contains(hand)) {
        _selectedHands.remove(hand);
      } else {
        _selectedHands.add(hand);
      }
      _currentPreset = RangePreset.none;
    });
  }

  void _applyPreset(RangePreset preset) {
    setState(() {
      _currentPreset = preset;
      _selectedHands.clear();

      switch (preset) {
        case RangePreset.none:
          break;
        case RangePreset.allPairs:
          _selectedHands.addAll(_allPairs);
          break;
        case RangePreset.allBroadway:
          _selectedHands.addAll(_broadwayHands);
          break;
        case RangePreset.random:
          // Select all hands for random mode
          for (int row = 0; row < 13; row++) {
            for (int col = 0; col < 13; col++) {
              final rank1 = _ranks[row];
              final rank2 = _ranks[col];
              if (row == col) {
                _selectedHands.add('$rank1$rank2');
              } else if (row < col) {
                _selectedHands.add('$rank1${rank2}s');
              } else {
                _selectedHands.add('$rank2${rank1}o');
              }
            }
          }
          break;
        default:
          // Top X% hands
          final count = (_topHandsOrder.length * preset.percentage / 100)
              .round();
          _selectedHands.addAll(_topHandsOrder.take(count));
      }
    });
  }

  void _clearAll() {
    setState(() {
      _selectedHands.clear();
      _currentPreset = RangePreset.none;
    });
  }

  Color _getHandColor(HandCombination hand, bool isSelected) {
    if (isSelected) {
      return Colors.green.shade600;
    }

    if (hand.isPair) {
      return Colors.blue.shade800;
    } else if (hand.isSuited) {
      return Colors.purple.shade800;
    } else {
      return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hands = _generateHandGrid();
    final selectedPercentage = (_selectedHands.length / 169 * 100)
        .toStringAsFixed(1);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Hand Range',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: widget.onCancel,
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Pairs', Colors.blue.shade800),
                const SizedBox(width: 16),
                _buildLegendItem('Suited', Colors.purple.shade800),
                const SizedBox(width: 16),
                _buildLegendItem('Offsuit', Colors.grey.shade700),
                const SizedBox(width: 16),
                _buildLegendItem('Selected', Colors.green.shade600),
              ],
            ),
          ),

          // Preset buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: RangePreset.values.map((preset) {
                final isActive = _currentPreset == preset;
                return GestureDetector(
                  onTap: () => _applyPreset(preset),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.blue : Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      preset.displayName,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Grid
          Padding(
            padding: const EdgeInsets.all(8),
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 13,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: 169,
                itemBuilder: (context, index) {
                  final hand = hands[index];
                  final isSelected = _selectedHands.contains(hand.display);

                  return GestureDetector(
                    onTap: () => _toggleHand(hand.display),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getHandColor(hand, isSelected),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Text(
                              hand.display,
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Stats row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selected: ${_selectedHands.length} hands ($selectedPercentage%)',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: _clearAll,
                  child: Text(
                    'Clear All',
                    style: GoogleFonts.roboto(
                      color: Colors.red.shade300,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: widget.onCancel,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.roboto(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => widget.onRangeSelected(_selectedHands),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Apply Range',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.roboto(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }
}

/// Shows a modal bottom sheet with the range selector
Future<Set<String>?> showRangeSelectorModal(
  BuildContext context, {
  Set<String> initialSelectedHands = const {},
}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => RangeSelectorWidget(
        initialSelectedHands: initialSelectedHands,
        onRangeSelected: (hands) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(hands);
          }
        },
        onCancel: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    ),
  );
}
