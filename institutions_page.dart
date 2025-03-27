import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/create_page.dart';
import 'package:itqan/registerPage.dart';

import 'first_Page.dart';
import 'locales.dart';

class Institutions extends StatefulWidget {
  @override
  _InstitutionsState createState() => _InstitutionsState();
}
class _InstitutionsState extends State<Institutions> {
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

        backgroundColor: Colors.white,
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
            // Top section with gradient and image
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
                  "lib/images/Commissioned.gif",
                  scale: 0.7,
                ),
              ),
            ),

            // Bottom section with rounded container
            Align(

              alignment: Alignment.bottomCenter,

              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.9,
                padding: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[300],
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
                      LocaleData.body119.getString(context),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        LocaleData.body120.getString(context),

                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Elevated button similar to FirstPage
                    Material(
                      color: Colors.lightGreen[700],
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 40,
                          ),
                          child: Text(
                            LocaleData.body116.getString(context),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
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
