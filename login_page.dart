import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itqan/home_page.dart';

import '../my_button.dart';
import '../my_textfield.dart';
import 'locales.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  List<dynamic> predefinedUsers = [];
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    loadUsersFromJson();
    _flutterLocalization =FlutterLocalization.instance;
    _currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }

  Future<void> loadUsersFromJson() async {
    final String response = await rootBundle.loadString('json/useres.json');
    final data = await json.decode(response);
    setState(() {
      predefinedUsers = data;
    });
  }

  void singUserIn(BuildContext context) {
    final username = usernameController.text;
    final password = passwordController.text;
    final userExists = predefinedUsers.any((user) =>
    user['username'] == username && user['password'] == password);

    if (userExists) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(LocaleData.body142.getString(context)),
      ));

      // Navigate to HomePage after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage(isArabic: true,locale:null)),
      );
    }  else {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(LocaleData.body143.getString(context)),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(  LocaleData.body126.getString(context),
            style: TextStyle(color: Colors.white)),
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
        backgroundColor: Colors.amber,
      ),


      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                // Logo with gradient
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.amber, Colors.white],
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
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.lock,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Welcome text
                Text(
                  LocaleData.body144.getString(context),
                 style:  TextStyle(
                    color: Colors.blue,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                // Username text field
                MyTextField(
                  controller: usernameController,
                  hintText: context.formatString(LocaleData.body145, ["heba"]),
                  obscureText: false, validator: (value) {  },
                ),
                const SizedBox(height: 10),
                // Password text field
                MyTextField(
                  controller: passwordController,
                  hintText: context.formatString(LocaleData.body146, ["heba"]),
                  obscureText: true, validator: (value) {  },
                ),
                const SizedBox(height: 10),
                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        LocaleData.body147.getString(context),
                        style: TextStyle(color: Colors.blueAccent[700]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Sign-in button
                Material(

                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => singUserIn(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 80,
                      ),
                      child:  Text(
                        LocaleData.body148.getString(context),
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
                const SizedBox(height: 10),
                // Divider with text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          LocaleData.body149.getString(context),
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Register button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  RegisterPage(),
                            ),
                          );
                        },

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 80,
                          ),
                          child:  Text(
                            LocaleData.body150.getString(context),                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
