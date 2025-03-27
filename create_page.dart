import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/first_Page.dart';
import 'package:itqan/home_page.dart';
import 'package:itqan/institutions_page.dart';
import 'package:itqan/login_page.dart';
import 'package:itqan/registerPage.dart';
import 'package:itqan/ris.dart';

import 'admin.dart';
import 'locales.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        actions: [
          DropdownButton(
            value: _currentLocale,
            items: const [
              DropdownMenuItem(
                value: "en",
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: "ar",
                child: Text("Arabic"),
              ),
            ],
            onChanged: (value) {
              _setLocale(value);
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Top gradient background with user image
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              color: Colors.amber[300],
              child: Center(
                child: Image.asset(
                  "lib/images/Lucozade03.gif",
                  scale: 0.8,
                ),
              ),
            ),
            // Bottom section with content and elevated rounded container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.7,
                padding: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.yellow[500],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      LocaleData.body121.getString(context),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        LocaleData.body122.getString(context),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28,
                          height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Register Button
                    Material(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 220),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleData.body123.getString(context),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Responsible Button
                    Material(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Responsible(),
                            ),
                          );
                        },
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 220),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleData.body152.getString(context),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login Button
                    Material(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 220),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleData.body124.getString(context),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "ar") {
      _flutterLocalization.translate("ar");
    } else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}
