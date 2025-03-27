import 'package:flutter/material.dart';
import 'home_page.dart';
import 'account_page.dart';
import 'category_page.dart';

class LanguageAndRegionPage extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  LanguageAndRegionPage({required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language & Region'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('English (United States)'),
            onTap: () {
              onLocaleChange(Locale('en', 'US'));
              _updateLanguageAndReturn(context, Locale('en', 'US'));
            },
          ),
          ListTile(
            title: Text('العربية (الإمارات العربية المتحدة)'), // Arabic
            onTap: () {
              onLocaleChange(Locale('ar', 'AE'));
              _updateLanguageAndReturn(context, Locale('ar', 'AE'));
            },
          ),
        ],
      ),
    );
  }

  void _updateLanguageAndReturn(BuildContext context, Locale locale) {
    // Navigate back to the previous screen with the new language
    Navigator.pop(context); // Pop the current language page

    // Update the existing pages to reflect the new language
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(isArabic: locale.languageCode == 'ar', locale: locale),
      ),
    );



    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(),
      ),
    );
  }
}
