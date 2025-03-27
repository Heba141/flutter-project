import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'language.dart';
import 'locales.dart';
import 'login_page.dart';
import 'personal_information.dart';
import 'widgets/privacysetting.dart';
import 'help.dart';
import 'notification.dart';
import 'user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Experience {
  final String position;
  final String company;
  final String duration;


  Experience(
      {required this.position, required this.company, required this.duration});
}

class AccountPage extends StatefulWidget {
  final Locale locale;
  final User user;

  AccountPage(
      {required this.locale, required this.user}); // Accept the locale in the constructor

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  List<Experience> userExperiences = [];
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // List<Experience> userExperiences = [];

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    // Add a fake experience
    ///userExperiences.add(
    //userExperiences.add(
    File? _profileImage;

    Future<void> _pickImage() async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Image"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(
                        ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(
                        ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    // Experience(
    //  position: 'Software Engineer',
    //company: 'Amazon',
    //duration: 'Jan 2020 - Present',
    //),
    //);
  }

  // User user = User(name: 'heba_sbateen', email: 'hebasbateen7@gmail.com', phone: '1234567890', );
  // Function to handle image picking from camera or gallery
  Future<void> _pickImageFromSource(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

// Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context); // Close the dialog
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _profileImage = File(pickedFile.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context); // Close the dialog
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _profileImage = File(pickedFile.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Stack(
          children: [

            Container(
              height: 60,
              child: CustomPaint(
                painter: WavyFlagPainter(),
                child: Container(),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Image.asset(
                'lib/images/jor.jpg',
                height: 40,
              ),
            ),
          ],
        ),
        //title: Text(
        //LocaleData.body13.getString(context),
        //style: TextStyle(color: Colors.white),
        //),
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
              )
            ],
            onChanged: (value) {
              _setLocale(value);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  // GestureDetector to allow tapping on the profile image
                  // GestureDetector to allow tapping on the profile image
                  GestureDetector(
                    onTap: _pickImage, // Open image picker when tapped
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      // Position the edit icon
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: _profileImage != null
                              ? FileImage(
                                  _profileImage!) // Display the selected image
                              : AssetImage('lib/images/ddd.jpg')
                                  as ImageProvider, // Default profile image
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child:
                              Icon(Icons.camera_alt, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name, // Use the user name from the model
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.user.email, // Use the user email from the model
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Spacer(), // Push the edit icon to the far right
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () async {
                      final updatedUser = await Navigator.push<UserNotifier>(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Consumer<UserNotifier>(
                                  builder: (context, userNotifier, child) =>
                                      PersonalInformation(
                                          user: userNotifier.user,
                                          locale: widget.locale),
                                )),
                      );
                      if (updatedUser != null) {
                        setState(() {
                          //  user = updatedUser; // Update the user information if edited
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 10, color: Colors.grey[300]),

            // Experience Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleData.body14.getString(context),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  // Dynamically display user experiences
                  for (var experience in userExperiences)
                    _buildExperienceItem(
                      experience: experience,
                    ),

                  // Add experience button
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.amber,
                    ),
                    onPressed:
                        _showAddExperienceDialog, // Show dialog to add experience
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 10, color: Colors.grey[300]),

            // Account Settings Section
            _buildListTile(
              icon: Icons.person_outline,
              title: context.formatString(LocaleData.body21, ["heba"]),
              onTap: () async {
                final updatedUser = await Navigator.push<UserNotifier>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Consumer<UserNotifier>(
                        builder: (context, userNotifier, child) =>
                            PersonalInformation(
                                user: userNotifier.user,
                                locale: widget.locale),
                      )),
                );
                if (updatedUser != null) {
                  setState(() {
                    //   user = updatedUser; // Update the user information
                  });
                }
              },
            ),
            _buildListTile(
              icon: Icons.lock_outline,
              title: context.formatString(LocaleData.body22, ["heba"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PrivacySettingsPage(locale: Locale('ar', 'AE')),
                  ),
                );
              },
            ),
            _buildListTile(
              icon: Icons.notifications_outlined,
              title: context.formatString(LocaleData.body23, ["heba"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationPage(locale: Locale('ar', 'AE')),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Divider(thickness: 10, color: Colors.grey[300]),

            // Support and Actions Section
            _buildListTile(
              icon: Icons.help_outline,
              title: context.formatString(LocaleData.body24, ["heba"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HelpSupportPage(locale: Locale('ar', 'AE')),
                  ),
                );
              },
            ),
            _buildListTile(
              icon: Icons.logout,
              title: context.formatString(LocaleData.body25, ["heba"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Helper function to build a ListTile
  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  // Widget for an experience item
  Widget _buildExperienceItem({required Experience experience}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.work, color: Colors.amber),
        title: Text(experience.position,
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(experience.company),
            Text(experience.duration),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _deleteExperience(experience); // Call delete function
          },
        ),
      ),
    );
  }

  // Function to delete an experience
  void _deleteExperience(Experience experience) {
    setState(() {
      userExperiences.remove(experience); // Remove experience from the list
    });
  }

  // Show the add experience dialog
  void _showAddExperienceDialog() {
    String position = '';
    String company = '';
    String duration = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            LocaleData.body103.getString(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText:
                        context.formatString(LocaleData.body104, ["heba"])),
                onChanged: (value) {
                  position = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText:
                        context.formatString(LocaleData.body105, ["heba"])),
                onChanged: (value) {
                  company = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText:
                        context.formatString(LocaleData.body106, ["heba"])),
                onChanged: (value) {
                  duration = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                LocaleData.body107.getString(context),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userExperiences.add(Experience(
                    position: position,
                    company: company,
                    duration: duration,
                  ));
                });
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                LocaleData.body108.getString(context),
              ),
            ),
          ],
        );
      },
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
