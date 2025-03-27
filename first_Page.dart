import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/login_page.dart';
import 'package:itqan/user_%20page.dart';

import 'locales.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({super.key});
  @override
  _FirstPageState createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {

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
            backgroundColor: Colors.grey[100],
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Top gradient background with logo and shimmer effect
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(

                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  "lib/images/Health.gif",
                  scale: 0.7,
                ),
              ),
            ),

            // Bottom section with content and elevated rounded container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.8,
                padding: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.pink[200],
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
                      LocaleData.body114.getString(context),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 20),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child:
                      Text(
                        LocaleData.body115.getString(context),


                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Glowing button with animation
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const User(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 60,
                          ),
                          child:  Text(
                            LocaleData.body116.getString(context),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
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
