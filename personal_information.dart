// personal_information.dart
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'locales.dart';
import 'user.dart'; // Import the User model

class PersonalInformation extends StatefulWidget {
  final User user; // Accept the User object
  final Locale locale; // Accept the Locale for language support

  PersonalInformation({required this.user, required this.locale}); // Constructor to accept user data and locale

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformation> {
  //late FlutterLocalization _flutterLocalization;
  //late String _currentLocale;
  //@override
  //void initState(){
    //super.initState();
    //_flutterLocalization =FlutterLocalization.instance;
    //_currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  //}
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late FlutterLocalization _flutterLocalization;
  late TextEditingController _passwordController;

  late String _currentLocale;
  bool _isPasswordVisible=false;
  @override
  void initState(){
    super.initState();
    _flutterLocalization =FlutterLocalization.instance;
    _currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
    // Initialize controllers with the user's current data
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleData.body26.getString(context)),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: LocaleData.body27.getString(context)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleData.body28.getString(context);
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: LocaleData.body29.getString(context),),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleData.body30.getString(context);
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return LocaleData.body31.getString(context);
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: LocaleData.body32.getString(context),),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleData.body33.getString(context);
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return LocaleData.body34.getString(context);
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
               // obscureText: true,
                decoration: InputDecoration(
                  labelText: LocaleData.body137.getString(context),
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),

                  suffixIcon:
                  IconButton( // Step 3: Toggle icon button
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleData.body138.getString(context);
                  }
                  if (value.length < 6) {
                    return LocaleData.body139.getString(context);
                  }
                  if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(value)) {
                    return LocaleData.body140.getString(context);
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  var userNotifier = context.read<UserNotifier>();
                  userNotifier.setUser(User(name: _nameController.text, email: _emailController.text, phone: _phoneController.text, password: _passwordController.text));
                 // if (_formKey.currentState!.validate()) {
                   // // Process data and return updated User
                    //final updatedUser = User(
                    //  name: _nameController.text,
                      //email: _emailController.text,
                      //phone: _phoneController.text, username: '', password: '',
                   // );
                  //  Navigator.pop(context, updatedUser); // Return updated user
                  //}
                },
                child: Text(LocaleData.body35.getString(context),),
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
