import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ai_chat/data/models/ai_models.dart';
import '../../../ai_chat/presentation/providers/ai_service_provider.dart';
import '../screens/about_screen.dart';
import '../screens/ai_settings_screen.dart';
import '../screens/help_screen.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(aiConfigControllerProvider);

    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade900, const Color(0xFF1A1A2E)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/logo-transparent.png',
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Poker AA',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'AI Calculator',
                          style: GoogleFonts.roboto(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // AI Status Card
            configAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (config) => _buildAiStatusCard(context, config),
            ),
            const Divider(color: Colors.white12),
            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.calculate,
                    title: 'Calculator',
                    subtitle: 'Equity & odds calculation',
                    isSelected: true,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Divider(
                    color: Colors.white12,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildSectionHeader('Settings'),
                  _buildMenuItem(
                    context,
                    icon: Icons.smart_toy,
                    title: 'AI Settings',
                    subtitle: 'Configure AI provider',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AiSettingsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.tune,
                    title: 'Preferences',
                    subtitle: 'App settings',
                    onTap: () {
                      Navigator.of(context).pop();
                      _showComingSoon(context);
                    },
                  ),
                  const Divider(
                    color: Colors.white12,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildSectionHeader('Support'),
                  _buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: 'Help & Guide',
                    subtitle: 'Learn how to use the app',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HelpScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.school,
                    title: 'Poker Academy',
                    subtitle: 'Learn poker strategy',
                    onTap: () {
                      Navigator.of(context).pop();
                      _showComingSoon(context);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.feedback_outlined,
                    title: 'Send Feedback',
                    subtitle: 'Help us improve',
                    onTap: () {
                      Navigator.of(context).pop();
                      _showFeedbackDialog(context);
                    },
                  ),
                  const Divider(
                    color: Colors.white12,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'App info & credits',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AboutScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Version 1.0.0',
                style: GoogleFonts.roboto(color: Colors.white38, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAiStatusCard(BuildContext context, AiConfig config) {
    final isConfigured =
        config.provider == AiProvider.mock || config.apiKey.isNotEmpty;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AiSettingsScreen()));
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isConfigured
              ? Colors.green.withValues(alpha: 0.15)
              : Colors.orange.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isConfigured
                ? Colors.green.withValues(alpha: 0.3)
                : Colors.orange.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isConfigured
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isConfigured ? Icons.check_circle : Icons.warning,
                color: isConfigured ? Colors.green : Colors.orange,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI: ${config.provider.displayName}',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    isConfigured ? 'Ready to use' : 'API key required',
                    style: GoogleFonts.roboto(
                      color: isConfigured ? Colors.green : Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.roboto(
          color: Colors.white38,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green.withValues(alpha: 0.2)
              : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.green : Colors.white70,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: isSelected ? Colors.green : Colors.white,
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.roboto(color: Colors.white54, fontSize: 12),
      ),
      trailing: isSelected
          ? Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.construction, color: Colors.amber),
            const SizedBox(width: 12),
            Text(
              'Coming soon!',
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Send Feedback',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'We appreciate your feedback! Please choose an option:',
              style: GoogleFonts.roboto(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            _buildFeedbackOption(
              context,
              Icons.bug_report,
              'Report a Bug',
              Colors.red,
            ),
            const SizedBox(height: 8),
            _buildFeedbackOption(
              context,
              Icons.lightbulb,
              'Suggest a Feature',
              Colors.amber,
            ),
            const SizedBox(height: 8),
            _buildFeedbackOption(
              context,
              Icons.rate_review,
              'Rate the App',
              Colors.green,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackOption(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Thank you! This feature is coming soon.',
              style: GoogleFonts.roboto(),
            ),
            backgroundColor: color.withValues(alpha: 0.8),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 15),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: color.withValues(alpha: 0.7)),
          ],
        ),
      ),
    );
  }
}
