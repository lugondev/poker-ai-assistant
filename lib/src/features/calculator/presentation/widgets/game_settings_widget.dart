import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/game_settings.dart';

/// Widget for configuring game settings (blinds, stacks, etc.)
class GameSettingsWidget extends StatefulWidget {
  final GameSettings currentSettings;
  final void Function(GameSettings) onSettingsChanged;
  final VoidCallback? onClose;

  const GameSettingsWidget({
    super.key,
    required this.currentSettings,
    required this.onSettingsChanged,
    this.onClose,
  });

  @override
  State<GameSettingsWidget> createState() => _GameSettingsWidgetState();
}

class _GameSettingsWidgetState extends State<GameSettingsWidget> {
  late TextEditingController _sbController;
  late TextEditingController _bbController;
  late TextEditingController _anteController;
  late TextEditingController _stackController;
  late GameType _gameType;

  @override
  void initState() {
    super.initState();
    _sbController = TextEditingController(
      text: widget.currentSettings.smallBlind.toStringAsFixed(0),
    );
    _bbController = TextEditingController(
      text: widget.currentSettings.bigBlind.toStringAsFixed(0),
    );
    _anteController = TextEditingController(
      text: widget.currentSettings.ante.toStringAsFixed(0),
    );
    _stackController = TextEditingController(
      text: widget.currentSettings.defaultStack.toStringAsFixed(0),
    );
    _gameType = widget.currentSettings.gameType;
  }

  @override
  void dispose() {
    _sbController.dispose();
    _bbController.dispose();
    _anteController.dispose();
    _stackController.dispose();
    super.dispose();
  }

  void _applyPreset(BlindPreset preset) {
    setState(() {
      _sbController.text = preset.smallBlind.toStringAsFixed(0);
      _bbController.text = preset.bigBlind.toStringAsFixed(0);
      _anteController.text = (preset.ante ?? 0).toStringAsFixed(0);
      _stackController.text = preset.defaultStack.toStringAsFixed(0);
    });
  }

  void _saveSettings() {
    final sb = double.tryParse(_sbController.text) ?? 1;
    final bb = double.tryParse(_bbController.text) ?? 2;
    final ante = double.tryParse(_anteController.text) ?? 0;
    final stack = double.tryParse(_stackController.text) ?? 100;

    widget.onSettingsChanged(
      GameSettings(
        smallBlind: sb,
        bigBlind: bb,
        ante: ante,
        defaultStack: stack,
        gameType: _gameType,
      ),
    );
    // Note: Don't call onClose here because onSettingsChanged already handles navigation
  }

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    const Icon(Icons.settings, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Game Settings',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Preset buttons
                Text(
                  'Quick Presets',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: BlindPreset.presets.map((preset) {
                    return GestureDetector(
                      onTap: () => _applyPreset(preset),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          preset.name,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Game type selector
                Text(
                  'Game Type',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: GameType.values.map((type) {
                    final isSelected = _gameType == type;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _gameType = type),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              type.displayName,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Blinds input
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: 'Small Blind',
                        controller: _sbController,
                        prefix: '\$',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInputField(
                        label: 'Big Blind',
                        controller: _bbController,
                        prefix: '\$',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: 'Ante',
                        controller: _anteController,
                        prefix: '\$',
                        hint: '0 = No Ante',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInputField(
                        label: 'Default Stack',
                        controller: _stackController,
                        prefix: '\$',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Stack in BB display
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Starting Stack: ',
                        style: GoogleFonts.roboto(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _calculateStackInBB(),
                        style: GoogleFonts.robotoMono(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: widget.onClose,
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
                    onPressed: _saveSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Apply Settings',
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

  String _calculateStackInBB() {
    final stack = double.tryParse(_stackController.text) ?? 100;
    final bb = double.tryParse(_bbController.text) ?? 2;
    if (bb <= 0) return '-- BB';
    final bbCount = stack / bb;
    return '${bbCount.toStringAsFixed(0)} BB';
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? prefix,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 16),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            prefixText: prefix,
            prefixStyle: GoogleFonts.robotoMono(
              color: Colors.white70,
              fontSize: 16,
            ),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            filled: true,
            fillColor: Colors.grey.shade800,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

/// Shows a modal bottom sheet with game settings
Future<GameSettings?> showGameSettingsModal(
  BuildContext context, {
  required GameSettings currentSettings,
}) {
  return showModalBottomSheet<GameSettings>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => GameSettingsWidget(
        currentSettings: currentSettings,
        onSettingsChanged: (settings) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(settings);
          }
        },
        onClose: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    ),
  );
}
