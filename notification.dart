import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/locales.dart';

class Notification {
  final String title;
  final String message;
  final String time;

  Notification({required this.title, required this.message, required this.time});
}

class NotificationPage extends StatefulWidget {
  final Locale locale; // Add locale parameter


  NotificationPage({required this.locale}); // Constructor accepting locale
  @override
  _NotificationPageState createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
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
    final List<Notification> notifications = [
    Notification(
        title:context.formatString(LocaleData.body48, ["heba"]),
        message: context.formatString(LocaleData.body49, ["heba"]),
        time: context.formatString(LocaleData.body50, ["heba"])),
    Notification(title: context.formatString(LocaleData.body51, ["heba"]),
    message: context.formatString(LocaleData.body52, ["heba"]),
    time: context.formatString(LocaleData.body53, ["heba"])),
    Notification(title: context.formatString(LocaleData.body54, ["heba"]),
    message: context.formatString(LocaleData.body55, ["heba"]),
    time: context.formatString(LocaleData.body56, ["heba"])),
    Notification(title: context.formatString(LocaleData.body57, ["heba"]),
    message: context.formatString(LocaleData.body58, ["heba"]),
    time: context.formatString(LocaleData.body59, ["heba"]))
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleData.body00.getString(context),),
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
      ], // Change title based on locale
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.blue),
              title: Text(
               notification.title, // Title in Arabic if selected
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                  notification.message,

          // Message in Arabic if selected
                  ),
                  SizedBox(height: 5),
                  Text(notification.time, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          );
        },
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

