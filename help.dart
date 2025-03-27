import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'locales.dart';

class HelpSupportPage extends StatefulWidget {
  final Locale locale;

  HelpSupportPage({required this.locale}); // Accept the locale in the constructor
  //@override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}
class _HelpSupportPageState extends State<HelpSupportPage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  @override
  void initState(){
    super.initState();
    _flutterLocalization =FlutterLocalization.instance;
    _currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleData.body60.getString(context),
      ), actions:[DropdownButton(
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
        child: ListView(
          children: [
            Text(
              LocaleData.body61.getString(context),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            FAQTile(
              question: LocaleData.body62.getString(context),
              answer: LocaleData.body63.getString(context),
            ),
            FAQTile(
              question: LocaleData.body64.getString(context),
              answer:LocaleData.body65.getString(context),
            ),
            FAQTile(
              question: LocaleData.body66.getString(context),
              answer: LocaleData.body67.getString(context),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(LocaleData.body68.getString(context)),
                    content: Text(LocaleData.body69.getString(context)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(LocaleData.body70.getString(context)),
                      ),
                    ],
                  ),
                );
              },
              child: Text(LocaleData.body71.getString(context)),
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

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  FAQTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
