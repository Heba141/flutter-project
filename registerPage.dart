import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/home_page.dart';
import 'package:itqan/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'locales.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
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
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {

      var userNotifier = context.read<UserNotifier>();
      userNotifier.setUser(User(name: nameController.text, email: emailController.text, phone: userNotifier.user.phone, password: passwordController.text,));


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(isArabic: true, locale: null),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text( LocaleData.body125.getString(context),
        )),
      );
    }
  }

  // Register user with backend
  Future<void>registerUser()  async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/users/register'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': nameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      print('Registration Successful, Token: ${data['token']}');

      var userNotifier = context.read<UserNotifier>();
      userNotifier.setUser(User(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: userNotifier.user.phone,
      ));

      // Navigate to HomePage upon successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(isArabic: _currentLocale == "ar", locale: _currentLocale),
        ),
      );
    } else {
      // Show error message
      final errorData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed: ${errorData['message']}")),
      );
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // First Name field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: context.formatString(LocaleData.body127, ["heba"]),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleData.body128.getString(context);
                  }
                //  if (!RegExp(r'^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$')
                  //    .hasMatch(value)) {
                    //return LocaleData.body129.getString(context);
                  //}
                  //return null;
                },
              ),
              SizedBox(height: 10),


              SizedBox(height: 10),

              // Email field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: LocaleData.body134.getString(context),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleData.body135.getString(context);
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return LocaleData.body136.getString(context);
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Password field
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: LocaleData.body137.getString(context),
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleData.body138.getString(context);
                  }
                  if (value.length < 6) {
                    return LocaleData.body139.getString(context);
                  }
                  if (RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()])[A-Za-z\d!@#$%^&*()]{6,}$')

                      .hasMatch(value)) {
                    return LocaleData.body140.getString(context);
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Create Account Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(LocaleData.body141.getString(context)
                    , style: TextStyle(fontSize: 18)),
              ),
            ],
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