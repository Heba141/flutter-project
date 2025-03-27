import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:itqan/first_Page.dart';
import 'package:itqan/locales.dart';
import 'package:itqan/user.dart';
import 'package:itqan/user_%20page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language.dart';
import 'account_page.dart'; // Import your AccountPage
import 'home_page.dart';

import 'logo.dart'; // Import your HomePage

void main() async{

  runApp(
    ChangeNotifierProvider(
      // Initialize the model in the builder. That way, Provider
      // can own Counter's lifecycle, making sure to call `dispose`
      // when not needed anymore.
      create: (context) => UserNotifier(),
      child:  MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  //Locale _locale = Locale('en', 'US');

  void _changeLanguage(Locale locale) {
    setState(() {
    //  _locale = locale;
    });
  }
  void initState(){
      configureLocalization();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Future<void> checkLoginStatus() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        // Navigate directly to HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(isArabic: true, locale: null)),
        );
      }
    }

    @override
    void initState() {
      super.initState();
      checkLoginStatus();
    }

    return MaterialApp(
     // locale: _locale,
      //supportedLocales: [
        //Locale('en', 'US'),
        //Locale('ar', 'AE'),
      //],
      //localizationsDelegates: [
        //GlobalMaterialLocalizations.delegate,
        //GlobalWidgetsLocalizations.delegate,
        //GlobalCupertinoLocalizations.delegate,
      //],
      supportedLocales : localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      home:SplashScreen (),
    );
  }
  void configureLocalization(){
   localization.init(mapLocales: LOCALES, initLanguageCode: "en");
   localization.onTranslatedLanguage =  onTranslatedLanguage;
  }
void onTranslatedLanguage(Locale?locale){
    setState(() {

    });

}
}
