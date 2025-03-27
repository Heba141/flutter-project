import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'locales.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController videoNameController = TextEditingController();
  final TextEditingController videoLinkController = TextEditingController();
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController jobCompanyController = TextEditingController();
  final TextEditingController jobSpecsController = TextEditingController();
  final TextEditingController jobLinkController = TextEditingController();

  // Set the default profile image path
  String _profileImageUrl = 'lib/images/ElectroRAI.png'; // Use your specified image

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImageUrl = pickedImage.path; // Update the profile image path
      });
    }
  }
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  @override
  void initState(){
    super.initState();
    _flutterLocalization =FlutterLocalization.instance;
    _currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }

  Future<void> publishVideo() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/publish/video'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": videoNameController.text,
        "link": videoLinkController.text,
        "profileName": "Fake Name", // Static fake name
        "profileEmail": "fakeemail@example.com", // Static fake email
      }),
    );

    if (response.statusCode == 201) {
      print('Video published successfully');
    } else {
      print('Failed to publish video');
    }
  }

  Future<void> publishJob() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/publish/job'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": jobNameController.text,
        "company": jobCompanyController.text,
        "specifications": jobSpecsController.text,
        "applicationLink": jobLinkController.text,
        "profileName": "Fake Name", // Static fake name
        "profileEmail": "fakeemail@example.com", // Static fake email
      }),
    );

    if (response.statusCode == 201) {
      print('Job published successfully');
    } else {
      print('Failed to publish job');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( LocaleData.body153.getString(context),

      ),
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
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _profileImageUrl.isNotEmpty
                        ? FileImage(File(_profileImageUrl))
                        : AssetImage(_profileImageUrl) as ImageProvider, // Default image
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Display Static Fake Name and Email
            Text("ElectroRAI", style: TextStyle(fontSize: 16)),
            Text("ElectroRAI@gmail.com", style: TextStyle(fontSize: 16)),

            Divider(),

            // Video Addition Section
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(  LocaleData.body154.getString(context),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: videoNameController, decoration: InputDecoration(labelText:  LocaleData.body155.getString(context),
                          )),
                          TextField(controller: videoLinkController, decoration: InputDecoration(labelText: LocaleData.body156.getString(context),
                          )),
                          ElevatedButton(
                            onPressed: () {
                              publishVideo();
                              Navigator.of(context).pop(); // Close the dialog after publishing
                            },
                            child: Text( LocaleData.body157.getString(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.video_library, color: Colors.white),
                    SizedBox(width: 8),
                    Text(  LocaleData.body157.getString(context),
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),

            Divider(),

            // Job Addition Section
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text( LocaleData.body158.getString(context),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: jobNameController, decoration: InputDecoration(labelText:  LocaleData.body159.getString(context),
                          )),
                          TextField(controller: jobCompanyController, decoration: InputDecoration(labelText:LocaleData.body160.getString(context),
                          )),
                          TextField(controller: jobSpecsController, decoration: InputDecoration(labelText:LocaleData.body161.getString(context),
                          )),
                          TextField(controller: jobLinkController, decoration: InputDecoration(labelText: LocaleData.body162.getString(context),
                          )),
                          ElevatedButton(
                            onPressed: () {
                              publishJob();
                              Navigator.of(context).pop(); // Close the dialog after publishing
                            },
                            child: Text(LocaleData.body163.getString(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.business_center, color: Colors.white),
                    SizedBox(width: 8),
                    Text( LocaleData.body163.getString(context),
                         style: TextStyle(color: Colors.white)),
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
