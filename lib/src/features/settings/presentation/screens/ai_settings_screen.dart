import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ai_chat/data/models/ai_models.dart';
import '../../../ai_chat/presentation/providers/ai_service_provider.dart';

class AiSettingsScreen extends ConsumerStatefulWidget {
  const AiSettingsScreen({super.key});

  @override
  ConsumerState<AiSettingsScreen> createState() => _AiSettingsScreenState();
}

class _AiSettingsScreenState extends ConsumerState<AiSettingsScreen> {
  final _apiKeyController = TextEditingController();
  bool _isApiKeyVisible = false;
  bool _isTesting = false;
  String? _testResult;

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(aiConfigControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          'AI Settings',
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
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
        data: (config) => _buildContent(config),
      ),
    );
  }

  Widget _buildContent(AiConfig config) {
    // Update text controller when config changes
    if (_apiKeyController.text != config.apiKey) {
      _apiKeyController.text = config.apiKey;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('AI Provider'),
          const SizedBox(height: 12),
          _buildProviderSelector(config),
          const SizedBox(height: 24),
          _buildSectionTitle('API Configuration'),
          const SizedBox(height: 12),
          _buildApiKeyInput(config),
          const SizedBox(height: 16),
          _buildModelSelector(config),
          const SizedBox(height: 24),
          _buildTestConnection(config),
          const SizedBox(height: 24),
          _buildProviderInfo(config.provider),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildProviderSelector(AiConfig config) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: AiProvider.values.map((provider) {
          final isSelected = config.provider == provider;
          return _buildProviderTile(provider, isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildProviderTile(AiProvider provider, bool isSelected) {
    return InkWell(
      onTap: () {
        ref.read(aiConfigControllerProvider.notifier).setProvider(provider);
        setState(() {
          _testResult = null;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withValues(alpha: 0.2) : null,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.green, width: 2) : null,
        ),
        child: Row(
          children: [
            _buildProviderIcon(provider),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.displayName,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _getProviderDescription(provider),
                    style: GoogleFonts.roboto(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderIcon(AiProvider provider) {
    IconData icon;
    Color color;

    switch (provider) {
      case AiProvider.openai:
        icon = Icons.auto_awesome;
        color = Colors.green;
      case AiProvider.anthropic:
        icon = Icons.psychology;
        color = Colors.orange;
      case AiProvider.gemini:
        icon = Icons.diamond;
        color = Colors.blue;
      case AiProvider.grok:
        icon = Icons.rocket_launch;
        color = Colors.purple;
      case AiProvider.deepseek:
        icon = Icons.explore;
        color = Colors.cyan;
      case AiProvider.openrouter:
        icon = Icons.hub;
        color = Colors.pink;
      case AiProvider.mock:
        icon = Icons.science;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  String _getProviderDescription(AiProvider provider) {
    return switch (provider) {
      AiProvider.openai => 'GPT-4o, GPT-4o-mini',
      AiProvider.anthropic => 'Claude 3.5 Sonnet, Haiku',
      AiProvider.gemini => 'Gemini 1.5 Pro, Flash',
      AiProvider.grok => 'xAI Grok-beta',
      AiProvider.deepseek => 'DeepSeek Chat, Coder',
      AiProvider.openrouter => 'Access multiple AI models',
      AiProvider.mock => 'Demo mode - no API key needed',
    };
  }

  Widget _buildApiKeyInput(AiConfig config) {
    final isMock = config.provider == AiProvider.mock;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'API Key',
          style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _apiKeyController,
          enabled: !isMock,
          obscureText: !_isApiKeyVisible,
          style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: isMock
                ? 'Not required for demo mode'
                : 'Enter your API key',
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            fillColor: Colors.grey.shade900,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade700),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.green),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    _isApiKeyVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    setState(() {
                      _isApiKeyVisible = !_isApiKeyVisible;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.white54),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: _apiKeyController.text),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('API key copied')),
                    );
                  },
                ),
              ],
            ),
          ),
          onChanged: (value) {
            ref.read(aiConfigControllerProvider.notifier).setApiKey(value);
            setState(() {
              _testResult = null;
            });
          },
        ),
        const SizedBox(height: 8),
        Text(
          _getApiKeyHelp(config.provider),
          style: GoogleFonts.roboto(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }

  String _getApiKeyHelp(AiProvider provider) {
    return switch (provider) {
      AiProvider.openai => 'Get your key at platform.openai.com/api-keys',
      AiProvider.anthropic => 'Get your key at console.anthropic.com',
      AiProvider.gemini => 'Get your key at aistudio.google.com/apikey',
      AiProvider.grok => 'Get your key at console.x.ai',
      AiProvider.deepseek => 'Get your key at platform.deepseek.com',
      AiProvider.openrouter => 'Get your key at openrouter.ai/keys',
      AiProvider.mock => 'Demo mode uses built-in mock responses',
    };
  }

  Widget _buildModelSelector(AiConfig config) {
    final models = _getAvailableModels(config.provider);
    final currentModel = config.model.isNotEmpty
        ? config.model
        : config.provider.defaultModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Model',
          style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: DropdownButton<String>(
            value: models.contains(currentModel) ? currentModel : models.first,
            isExpanded: true,
            dropdownColor: Colors.grey.shade900,
            underline: const SizedBox(),
            style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 14),
            items: models.map((model) {
              return DropdownMenuItem(value: model, child: Text(model));
            }).toList(),
            onChanged: (value) {
              // TODO: Add model selection to provider
            },
          ),
        ),
      ],
    );
  }

  List<String> _getAvailableModels(AiProvider provider) {
    return switch (provider) {
      AiProvider.openai => [
        'gpt-4o',
        'gpt-4o-mini',
        'gpt-4-turbo',
        'gpt-4',
        'gpt-3.5-turbo',
      ],
      AiProvider.anthropic => [
        'claude-3-5-sonnet-20241022',
        'claude-3-5-haiku-20241022',
        'claude-3-opus-20240229',
        'claude-3-sonnet-20240229',
        'claude-3-haiku-20240307',
      ],
      AiProvider.gemini => [
        'gemini-1.5-pro',
        'gemini-1.5-flash',
        'gemini-1.5-flash-8b',
        'gemini-pro',
      ],
      AiProvider.grok => ['grok-beta', 'grok-2', 'grok-2-mini'],
      AiProvider.deepseek => [
        'deepseek-chat',
        'deepseek-coder',
        'deepseek-reasoner',
      ],
      AiProvider.openrouter => [
        'openai/gpt-4o-mini',
        'openai/gpt-4o',
        'anthropic/claude-3.5-sonnet',
        'google/gemini-pro-1.5',
        'meta-llama/llama-3.1-70b-instruct',
      ],
      AiProvider.mock => ['mock-model'],
    };
  }

  Widget _buildTestConnection(AiConfig config) {
    final isConfigured =
        config.provider == AiProvider.mock || config.apiKey.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: isConfigured && !_isTesting
              ? () => _testConnection(config)
              : null,
          icon: _isTesting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.wifi_tethering),
          label: Text(_isTesting ? 'Testing...' : 'Test Connection'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        if (_testResult != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _testResult!.startsWith('Success')
                  ? Colors.green.withValues(alpha: 0.2)
                  : Colors.red.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _testResult!.startsWith('Success')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _testResult!.startsWith('Success')
                      ? Icons.check_circle
                      : Icons.error,
                  color: _testResult!.startsWith('Success')
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _testResult!,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _testConnection(AiConfig config) async {
    setState(() {
      _isTesting = true;
      _testResult = null;
    });

    try {
      final service = ref.read(aiServiceProvider);

      final response = await service.getCompletion(
        AiCompletionRequest(
          messages: const [
            AiMessage(role: 'user', content: 'Say "Hello" in one word.'),
          ],
          maxTokens: 10,
          stream: false,
        ),
      );

      setState(() {
        _testResult = 'Success! Response: "${response.trim()}"';
      });
    } catch (e) {
      setState(() {
        _testResult = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isTesting = false;
      });
    }
  }

  Widget _buildProviderInfo(AiProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'About ${provider.displayName}',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getProviderInfo(provider),
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

  String _getProviderInfo(AiProvider provider) {
    return switch (provider) {
      AiProvider.openai =>
        '''
OpenAI offers GPT-4o, one of the most capable AI models. GPT-4o-mini is a cost-effective option for everyday use.

Pricing: Pay-per-token
Best for: General purpose, complex reasoning
''',
      AiProvider.anthropic =>
        '''
Anthropic's Claude models are known for being helpful, harmless, and honest. Claude 3.5 Sonnet offers excellent performance.

Pricing: Pay-per-token
Best for: Long conversations, nuanced analysis
''',
      AiProvider.gemini =>
        '''
Google's Gemini models offer multimodal capabilities and strong performance. Gemini 1.5 Flash is fast and efficient.

Pricing: Free tier available, then pay-per-token
Best for: Fast responses, budget-conscious users
''',
      AiProvider.grok =>
        '''
xAI's Grok is designed to be witty and has real-time knowledge. Currently in beta with limited access.

Pricing: Included with X Premium+
Best for: Real-time information, casual conversations
''',
      AiProvider.deepseek =>
        '''
DeepSeek offers competitive AI models at very affordable prices. DeepSeek-Chat is great for general use.

Pricing: Very low cost per token
Best for: Budget users, high-volume usage
''',
      AiProvider.openrouter =>
        '''
OpenRouter provides unified access to many AI models through a single API. Great for comparing different models.

Pricing: Varies by model (usually with small markup)
Best for: Flexibility, trying different models
''',
      AiProvider.mock =>
        '''
Demo mode uses pre-built responses for testing the app without requiring an API key.

Pricing: Free
Best for: Testing the app, offline use
''',
    };
  }
}
