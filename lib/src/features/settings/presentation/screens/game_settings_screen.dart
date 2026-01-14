import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../calculator/domain/entities/game_settings.dart';
import '../../../calculator/presentation/providers/calculator_controller.dart';

class GameSettingsScreen extends ConsumerStatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  ConsumerState<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends ConsumerState<GameSettingsScreen> {
  late TextEditingController _sbController;
  late TextEditingController _bbController;
  late TextEditingController _anteController;
  late TextEditingController _stackController;
  late GameType _gameType;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _sbController = TextEditingController();
    _bbController = TextEditingController();
    _anteController = TextEditingController();
    _stackController = TextEditingController();
    _gameType = GameType.cashGame;
  }

  void _initializeFromState(GameSettings settings) {
    if (!_isInitialized) {
      _sbController.text = settings.smallBlind.toStringAsFixed(0);
      _bbController.text = settings.bigBlind.toStringAsFixed(0);
      _anteController.text = settings.ante.toStringAsFixed(0);
      _stackController.text = settings.defaultStack.toStringAsFixed(0);
      _gameType = settings.gameType;
      _isInitialized = true;
    }
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

    final newSettings = GameSettings(
      smallBlind: sb,
      bigBlind: bb,
      ante: ante,
      defaultStack: stack,
      gameType: _gameType,
    );

    ref
        .read(calculatorControllerProvider.notifier)
        .updateGameSettings(newSettings);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              'Settings saved successfully',
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calculatorControllerProvider);
    _initializeFromState(state.gameSettings);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          'Game Settings',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _saveSettings,
            child: Text(
              'Save',
              style: GoogleFonts.roboto(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Presets Section
            _buildSectionHeader('Quick Presets', Icons.flash_on, Colors.amber),
            const SizedBox(height: 12),
            _buildPresetsGrid(),
            const SizedBox(height: 24),

            // Game Type Section
            _buildSectionHeader('Game Type', Icons.casino, Colors.purple),
            const SizedBox(height: 12),
            _buildGameTypeSelector(),
            const SizedBox(height: 24),

            // Blinds Section
            _buildSectionHeader('Blinds', Icons.monetization_on, Colors.green),
            const SizedBox(height: 12),
            _buildBlindsInputs(),
            const SizedBox(height: 24),

            // Stack Section
            _buildSectionHeader('Stack Settings', Icons.layers, Colors.blue),
            const SizedBox(height: 12),
            _buildStackInputs(),
            const SizedBox(height: 24),

            // Summary Card
            _buildSummaryCard(),
            const SizedBox(height: 24),

            // Save Button
            _buildSaveButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPresetsGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: BlindPreset.presets.map((preset) {
          return GestureDetector(
            onTap: () => _applyPreset(preset),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
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
    );
  }

  Widget _buildGameTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: GameType.values.map((type) {
          final isSelected = _gameType == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _gameType = type),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            Colors.green.shade600,
                            Colors.green.shade800,
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(color: Colors.green.shade400, width: 1)
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      _getGameTypeIcon(type),
                      color: isSelected ? Colors.white : Colors.white54,
                      size: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      type.displayName,
                      style: GoogleFonts.roboto(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getGameTypeIcon(GameType type) {
    switch (type) {
      case GameType.cashGame:
        return Icons.attach_money;
      case GameType.tournament:
        return Icons.emoji_events;
      case GameType.sitAndGo:
        return Icons.groups;
    }
  }

  Widget _buildBlindsInputs() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  label: 'Small Blind',
                  controller: _sbController,
                  prefix: '\$',
                  icon: Icons.looks_one,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInputField(
                  label: 'Big Blind',
                  controller: _bbController,
                  prefix: '\$',
                  icon: Icons.looks_two,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Ante (Optional)',
            controller: _anteController,
            prefix: '\$',
            hint: '0 = No Ante',
            icon: Icons.add_circle_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildStackInputs() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: _buildInputField(
        label: 'Default Starting Stack',
        controller: _stackController,
        prefix: '\$',
        icon: Icons.layers,
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? prefix,
    String? hint,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white54, size: 16),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 18),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            prefixText: prefix,
            prefixStyle: GoogleFonts.robotoMono(
              color: Colors.green,
              fontSize: 18,
            ),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            filled: true,
            fillColor: Colors.grey.shade800,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.green, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    final stack = double.tryParse(_stackController.text) ?? 100;
    final bb = double.tryParse(_bbController.text) ?? 2;
    final sb = double.tryParse(_sbController.text) ?? 1;
    final ante = double.tryParse(_anteController.text) ?? 0;
    final bbCount = bb > 0 ? (stack / bb) : 0;

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
        children: [
          Row(
            children: [
              const Icon(Icons.summarize, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                'Summary',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),
          _buildSummaryRow('Game Type', _gameType.displayName),
          _buildSummaryRow(
            'Blinds',
            '\$${sb.toStringAsFixed(0)} / \$${bb.toStringAsFixed(0)}',
          ),
          if (ante > 0)
            _buildSummaryRow('Ante', '\$${ante.toStringAsFixed(0)}'),
          _buildSummaryRow('Default Stack', '\$${stack.toStringAsFixed(0)}'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
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
                  '${bbCount.toStringAsFixed(0)} BB',
                  style: GoogleFonts.robotoMono(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveSettings,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.save, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              'Save Settings',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
