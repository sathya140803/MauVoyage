import 'package:flutter/material.dart';

class LanguageOption {
  final String code;
  final String name;
  final String nativeName;

  LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

class LanguageSettingsPage extends StatefulWidget {
  final Function(String)? onLanguageChanged;
  final String? currentLanguageCode;

  const LanguageSettingsPage({
    Key? key,
    this.onLanguageChanged,
    this.currentLanguageCode,
  }) : super(key: key);

  @override
  _LanguageSettingsPageState createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  late String _selectedLanguageCode;

  // List of supported languages
  final List<LanguageOption> _languages = [
    LanguageOption(code: 'en', name: 'English', nativeName: 'English'),
    LanguageOption(code: 'es', name: 'Spanish', nativeName: 'Español'),
    LanguageOption(code: 'fr', name: 'French', nativeName: 'Français'),
    LanguageOption(code: 'de', name: 'German', nativeName: 'Deutsch'),
    LanguageOption(code: 'zh', name: 'Chinese', nativeName: '中文'),
    LanguageOption(code: 'ja', name: 'Japanese', nativeName: '日本語'),
    LanguageOption(code: 'ko', name: 'Korean', nativeName: '한국어'),
    LanguageOption(code: 'ar', name: 'Arabic', nativeName: 'العربية'),
    LanguageOption(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी'),
    LanguageOption(code: 'pt', name: 'Portuguese', nativeName: 'Português'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedLanguageCode = widget.currentLanguageCode ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
        elevation: 1,
        backgroundColor: Colors.orange, // Set AppBar color to orange
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select your preferred language',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final language = _languages[index];
                return RadioListTile<String>(
                  title: Text(language.name),
                  subtitle: Text(language.nativeName),
                  value: language.code,
                  groupValue: _selectedLanguageCode,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLanguageCode = value;
                      });

                      if (widget.onLanguageChanged != null) {
                        widget.onLanguageChanged!(value);
                      }

                      // Show confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Language changed to ${language.name}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Example of how to use this in your main app:
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentLanguage = 'en';

  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
      // Here you would typically use a localization package to change the app's language
      // For example, with flutter_localizations and intl packages
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configure localization settings here
      home: HomePage(
        currentLanguage: _currentLanguage,
        onNavigateToLanguageSettings: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LanguageSettingsPage(
                currentLanguageCode: _currentLanguage,
                onLanguageChanged: _changeLanguage,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Example HomePage with a button to navigate to language settings
class HomePage extends StatelessWidget {
  final String currentLanguage;
  final VoidCallback onNavigateToLanguageSettings;

  const HomePage({
    Key? key,
    required this.currentLanguage,
    required this.onNavigateToLanguageSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: onNavigateToLanguageSettings,
            tooltip: 'Language Settings',
          ),
        ],
        backgroundColor: Colors.orange, // Set AppBar color to orange
      ),
      body: Center(
        child: Text('Current language: $currentLanguage'),
      ),
    );
  }
}