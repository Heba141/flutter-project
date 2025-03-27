import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../locales.dart';

class PrivacySettingsPage extends StatefulWidget {
  final Locale locale; // Add locale as a parameter

  PrivacySettingsPage({required this.locale}); // Accept locale in constructor

  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  @override
  void initState(){
    super.initState();
    _flutterLocalization =FlutterLocalization.instance;
    _currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }

  bool _locationAccess = true;
  bool _dataSharing = false;
  bool _adPersonalization = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleData.body36.getString(context),),
        actions:[DropdownButton(
          value: _currentLocale,
          items: const[DropdownMenuItem(
              value: "en",child:
          Text("english")
          ),
            DropdownMenuItem(
                value: "ar",
                child:
                Text("arabic")
            )
          ]
          ,onChanged: (value){
          _setLocale(value);
        },
        )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text(LocaleData.body37.getString(context),), // Change title based on locale
              subtitle: Text(LocaleData.body38.getString(context),), // Change subtitle based on locale
              value: _locationAccess,
              onChanged: (bool value) {
                setState(() {
                  _locationAccess = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(LocaleData.body39.getString(context),), // Change title based on locale
              subtitle: Text(LocaleData.body40.getString(context),), // Change subtitle based on locale
              value: _dataSharing,
              onChanged: (bool value) {
                setState(() {
                  _dataSharing = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(LocaleData.body41.getString(context),), // Change title based on locale
              subtitle: Text(LocaleData.body42.getString(context),), // Change subtitle based on locale
              value: _adPersonalization,
              onChanged: (bool value) {
                setState(() {
                  _adPersonalization = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save settings or show a dialog with current settings
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(LocaleData.body43.getString(context),), // Change title based on locale
                    content: Text(LocaleData.body44.getString(context),), // Change content based on locale
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(LocaleData.body45.getString(context),), // Change button text based on locale
                      ),
                    ],
                  ),
                );
              },
              child: Text(LocaleData.body46.getString(context),), // Change button text based on locale
            ),
          ],
        ),
      ),
    );
  }
  void _setLocale(String?value){
    if(value==null)return;
    if(value== "en"){
      _flutterLocalization.translate("en");

    } else if(value== "ar"){
      _flutterLocalization.translate("ar");
    }else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}
