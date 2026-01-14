import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          'About',
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
          children: [
            const SizedBox(height: 20),
            // App Logo
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/logo-transparent.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              'Poker AA',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'AI-Powered Poker Calculator',
              style: GoogleFonts.roboto(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.withValues(alpha: 0.5)),
              ),
              child: Text(
                'Version $appVersion ($buildNumber)',
                style: GoogleFonts.robotoMono(
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Features Section
            _buildSection('Features', Icons.star, Colors.amber, [
              _buildFeatureItem(
                Icons.calculate,
                'Monte Carlo Equity Calculation',
              ),
              _buildFeatureItem(Icons.people, 'Multi-player Support (up to 9)'),
              _buildFeatureItem(Icons.grid_view, 'Hand Range Analysis'),
              _buildFeatureItem(Icons.smart_toy, 'AI Strategy Assistant'),
              _buildFeatureItem(Icons.speed, 'Real-time Pot Odds'),
              _buildFeatureItem(Icons.offline_bolt, 'Offline Support'),
            ]),
            const SizedBox(height: 24),
            // Technology Section
            _buildSection('Technology', Icons.code, Colors.blue, [
              _buildFeatureItem(Icons.flutter_dash, 'Built with Flutter'),
              _buildFeatureItem(Icons.memory, 'Monte Carlo Simulation'),
              _buildFeatureItem(Icons.auto_awesome, 'Multiple AI Providers'),
              _buildFeatureItem(Icons.security, 'Secure API Key Storage'),
            ]),
            const SizedBox(height: 24),
            // AI Providers Section
            _buildSection('Supported AI Providers', Icons.hub, Colors.purple, [
              _buildFeatureItem(Icons.auto_awesome, 'OpenAI (GPT-4o)'),
              _buildFeatureItem(Icons.psychology, 'Anthropic (Claude)'),
              _buildFeatureItem(Icons.diamond, 'Google Gemini'),
              _buildFeatureItem(Icons.rocket_launch, 'xAI Grok'),
              _buildFeatureItem(Icons.explore, 'DeepSeek'),
              _buildFeatureItem(Icons.hub, 'OpenRouter'),
            ]),
            const SizedBox(height: 24),
            // Credits Section
            _buildSection('Credits', Icons.favorite, Colors.red, [
              _buildCreditItem('Development', 'Poker AA Team'),
              _buildCreditItem('UI/UX Design', 'Material Design 3'),
              _buildCreditItem('Icons', 'Material Icons'),
              _buildCreditItem('Fonts', 'Google Fonts (Roboto)'),
            ]),
            const SizedBox(height: 24),
            // Legal Section
            _buildSection('Legal', Icons.gavel, Colors.grey, [
              _buildLegalItem(
                context,
                'Terms of Service',
                Icons.description,
                () => _showTermsDialog(context),
              ),
              _buildLegalItem(
                context,
                'Privacy Policy',
                Icons.privacy_tip,
                () => _showPrivacyDialog(context),
              ),
              _buildLegalItem(
                context,
                'Open Source Licenses',
                Icons.source,
                () => _showLicensesPage(context),
              ),
            ]),
            const SizedBox(height: 32),
            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Made with ♥ for poker enthusiasts',
                    style: GoogleFonts.roboto(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '© 2024-2026 Poker AA. All rights reserved.',
                    style: GoogleFonts.roboto(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
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
    List<Widget> children,
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
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditItem(String role, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            role,
            style: GoogleFonts.roboto(color: Colors.white54, fontSize: 14),
          ),
          Text(
            name,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Terms of Service',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Text(
            '''
Terms of Service for Poker AA

Last updated: January 2026

1. Acceptance of Terms
By using Poker AA, you agree to these terms.

2. Use of Service
- This app is for educational and entertainment purposes only
- Do not use this app for illegal gambling activities
- Results are based on mathematical probability, not guarantees

3. AI Features
- AI responses are for informational purposes only
- The app connects to third-party AI services
- You are responsible for your own API keys and usage

4. Disclaimer
- We do not guarantee accuracy of calculations
- Past results do not guarantee future outcomes
- Use at your own risk

5. Privacy
- We do not collect personal information
- API keys are stored locally on your device
- See Privacy Policy for details

6. Changes
We may update these terms at any time.

7. Contact
For questions, contact us through the app store listing.
''',
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: GoogleFonts.roboto(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Text(
            '''
Privacy Policy for Poker AA

Last updated: January 2026

1. Information We Collect
- We do not collect personal information
- We do not track your usage
- We do not share any data with third parties

2. Data Storage
- API keys are stored locally using secure storage
- All calculations happen on your device
- Chat history is stored locally only

3. Third-Party Services
- AI features connect to external APIs
- Your queries are sent to AI providers you configure
- Review each provider's privacy policy

4. Security
- API keys are encrypted on device
- No data is transmitted to our servers
- We follow security best practices

5. Children's Privacy
- This app is not intended for children under 13
- We do not knowingly collect data from children

6. Changes
We may update this policy at any time.

7. Contact
For questions, contact us through the app store listing.
''',
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: GoogleFonts.roboto(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  void _showLicensesPage(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'Poker AA',
      applicationVersion: '$appVersion ($buildNumber)',
      applicationIcon: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/logo-transparent.png',
            width: 48,
            height: 48,
          ),
        ),
      ),
      applicationLegalese: '© 2024-2026 Poker AA. All rights reserved.',
    );
  }
}
