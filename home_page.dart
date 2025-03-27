import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/account_page.dart';
import 'package:itqan/bookstore_page.dart';
import 'package:itqan/category_page.dart';
import 'package:itqan/classes_page.dart';
import 'package:itqan/course_screen.dart';
import 'package:itqan/freelancer.dart';
import 'package:itqan/locales.dart';
import 'package:itqan/opportunities_page.dart';
import 'package:itqan/user.dart';
import 'package:itqan/wishlist_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favorite.dart';
// Import the FavoritesPage

class HomePage extends StatefulWidget {
  final bool isArabic; // Boolean to control the language

  HomePage({required this.isArabic, required this.locale});

  // HomePage({super.key, required bool isArabic});
  var locale;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';

  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;


  final List<Map<String, String>> englishJobOpportunities = [
    {
      'title': 'Machine Learning Engineer',
      'company': 'ElectroRAI',
      'location': 'Amman',
      'applicationUrl': 'https://fakeapplication.com/ml-engineer',
    },
    {
      'title': 'Java Developer',
      'company': 'ElectroRAI',
      'location': 'Jarash',
      'applicationUrl': 'https://fakeapplication.com/java-developer',
    },
    {
      'title': 'Computer Trainer',
      'company': 'ElectroRAI',
      'location': 'Amman',
      'applicationUrl': 'https://fakeapplication.com/computer-trainer',
    },
    {
      'title': 'Web Designer',
      'company': 'ElectroRAI',
      'location': 'Salt',
      'applicationUrl': 'https://fakeapplication.com/web-designer',
    },
    {
      'title': 'AI Developer',
      'company': 'ElectroRAI',
      'location': 'Salt',
      'applicationUrl': 'https://fakeapplication.com/ai-developer',
    },
    {
      'title': 'PHP Developer',
      'company': 'ElectroRAI',
      'location': 'Salt',
      'applicationUrl': 'https://fakeapplication.com/php-developer',
    },
  ];

  final List<Map<String, String>> arabicJobOpportunities = [
    {
      'title': 'مهندس تعلم الآلة',
      'company': 'إلكتروراي',
      'location': 'عمان',
      'applicationUrl': 'https://fakeapplication.com/ml-engineer',
    },
    {
      'title': 'مطوّر جافا',
      'company': 'إلكتروراي',
      'location': 'جرش',
      'applicationUrl': 'https://fakeapplication.com/java-developer',
    },
    {
      'title': 'مدرب حاسوب',
      'company': 'إلكتروراي',
      'location': 'عمان',
      'applicationUrl': 'https://fakeapplication.com/computer-trainer',
    },
    {
      'title': 'مصمم ويب',
      'company': 'إلكتروراي',
      'location': 'السلط',
      'applicationUrl': 'https://fakeapplication.com/web-designer',
    },
    {
      'title': 'مطوّر الذكاء الاصطناعي',
      'company': 'إلكتروراي',
      'location': 'السلط',
      'applicationUrl': 'https://fakeapplication.com/ai-developer',
    },
    {
      'title': 'مطوّر PHP',
      'company': 'إلكتروراي',
      'location': 'السلط',
      'applicationUrl': 'https://fakeapplication.com/php-developer',
    },
  ];
  late List<Map<String, String>> jobOpportunities;



  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }

  List<Map<String, String>> videoInfo = [
    {
      "Coursetype": "Machine learning",
      "thumbnail": "lib/images/ElectroRAI.png",
      "time": "2h and 35m",
      "title": "ElectroRAI ",
      "videoUrl":
          "https://drive.usercontent.google.com/download?id=1QFwCcbSAB76yJgMXHfK9s92km9GX-ZAa&export=download&confirm=t"
    },
    {
      "Coursetype": "Java Development",
      "thumbnail": "lib/images/ElectroRAI.png",
      "time": "2h and 35m",
      "title": "ElectroRAI",
      "videoUrl":
          "https://drive.usercontent.google.com/download?id=1QFwCcbSAB76yJgMXHfK9s92km9GX-ZAa&export=download&confirm=t"
    },
    {
      "Coursetype": "Flutter",
      "thumbnail": "lib/images/ElectroRAI.png",
      "time": "2h and 35m",
      "title": "ElectroRAI",
      "videoUrl":
          "https://drive.usercontent.google.com/download?id=1QFwCcbSAB76yJgMXHfK9s92km9GX-ZAa&export=download&confirm=t"
    },
    {
      "Coursetype": "AI Development",
      "thumbnail": "lib/images/ElectroRAI.png",
      "time": "2h and 35m",
      "title": "ElectroRAI",
      "videoUrl":
          "https://drive.usercontent.google.com/download?id=1QFwCcbSAB76yJgMXHfK9s92km9GX-ZAa&export=download&confirm=t"
    },
    {
      "Coursetype": "AI",
      "thumbnail": "lib/images/ElectroRAI.png",
      "time": "2h and 35m",
      "title": "ElectroRAI",
      "videoUrl":
          "https://drive.usercontent.google.com/download?id=1QFwCcbSAB76yJgMXHfK9s92km9GX-ZAa&export=download&confirm=t"
    }
  ];

  // Data lists
  List<String> catNames = [
    "Category",
    "Opportunities",
    "Classes",
    "BookStore",
    "Leaderboard",
  ]; // English and Arabic versions of the data
  List<String> examples1 = ['ElectroRAI', 'ElectroRAI'];
  List<String> examples1Ar = ['إلكتروراي', 'إلكتروراي'];

  List<String> examples2 = ['Machine Learning Engineer', 'Java Developer'];
  List<String> examples2Ar = ['مهندس تعلم الآلة', 'مطور جافا'];

  List<String> examples3 = ['Design', 'Marketing'];
  List<String> examples3Ar = ['التصميم', 'التسويق'];

  List<String> examples4 = ['Moby Dick', 'Great Gatsby'];
  List<String> examples4Ar = ['موبي ديك', 'جاتسبي العظيم'];
  // Map each item to a specific page



  // Categories names
  //List<String> catNames = ["Category", "Opportunities", "Classes", "BookStore", "Leaderboard"];
  //List<String> catNamesAr = ["الفئة", "الفرص", "الصفوف", "المكتبة", "لوحة المتصدرين"];
  // List<String> examples1 = ['ElectroRAI', 'ElectroRAI']; // Updated examples for Category
  //List<String> examples2 = ["Machine Learning Engineer","Java Developer"]; // Examples for Opportunities
  //List<String> examples3 = ["Design", "Marketing"]; // Examples for Classes
  //List<String> examples4 = ["Moby Dick", "Great gatsby"]; // Examples for BookStore

  List<IconWithExamples> buildIconWithExamples(BuildContext context) {
    return [
      IconWithExamples(

        icon: Icons.category,
        title: context.formatString(LocaleData.body, ["heba"]),
        //"Category",
        examples: _currentLocale == 'en' ? examples1 : examples1Ar,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryPage()),
          );
        },
      ),
      IconWithExamples(
        icon:
          Icons.work,
        title: context.formatString(LocaleData.body2, ["heba"]),
        examples: _currentLocale == 'en' ? examples2 : examples2Ar,
        onPressed: () {
          var job;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OpportunitiesPage()));
        },
      ),
      IconWithExamples(
        icon: Icons.video_library,
        title: context.formatString(LocaleData.body3, ["heba"]),
        examples: _currentLocale == 'en' ? examples3 : examples3Ar,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ClassesPage(locale: Locale('ar', 'AE'))));
        },
      ),
      IconWithExamples(

        icon: Icons.store,
        title: context.formatString(LocaleData.body4, ["heba"]),
        examples: _currentLocale == 'en' ? examples4 : examples4Ar,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookStorePage(locale: Locale('ar', 'AE'))));
        },
      ),
    ];
  }

  int _selectedIndex = 0;
  List<String> searchResults = [];
  bool noResultsFound = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      isArabic: true,
                      locale: null,
                    )));
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WishlistPage()));
      } else if (index == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (
              context,
            ) => Consumer<UserNotifier>(
                    builder: (context, userNotifier, child) => AccountPage(
                        locale: const Locale('ar', 'AE'),
                        user: userNotifier.user))));
      }
    });
  }

  void _search(String query) {
    searchResults.clear();
    noResultsFound = false;

    if (query.isEmpty) {
      setState(() {});
      return;
    }

    List<String> combinedList = [
      ...catNames,
      ...examples1,
      ...examples2,
      ...examples3,
      ...examples4,
    ];
    for (var item in combinedList) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(item);
      }
    }

    if (searchResults.isEmpty) {
      noResultsFound = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background to white
        title: Stack(
          children: [
            // Draw the wavy flag background
            Container(
              height: 60,
              child: CustomPaint(
                painter: WavyFlagPainter(),
                child: Container(),
              ),
            ),
            // Add the Jordanian flag image
            Positioned(
              top: 10,
              left: 10,
              child: Image.asset(
                'lib/images/jor.jpg', // Replace with the actual flag URL
                height: 40,
              ),
            ),
          ],
        ),

        //title:
        //Text( LocaleData.title.getString(context),

        //style: TextStyle(fontSize: 30,
        // fontStyle: FontStyle.italic,
        //),
        //),
        actions: [
          DropdownButton(
            value: _currentLocale,
            items: const [
              DropdownMenuItem(value: "en", child: Text("english")),
              DropdownMenuItem(value: "ar", child: Text("arabic"))
            ],
            onChanged: (value) {
              _setLocale(value);
            },
          )
        ],
      ),

      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 1, left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleData.title.getString(context),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.amber),
                    ),
                    const SizedBox(width: 180),
                    IconButton(
                      icon: const Icon(Icons.favorite,
                          color: Colors.amber, size: 30),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritesPage()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_sharp,
                          color: Colors.amber, size: 30),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreelancerPage()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextFormField(

                    onChanged: (value) {
                      _search(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          context.formatString(LocaleData.body5, ["heba"]),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Display search results at the top
          if (searchResults.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: searchResults.map((result) {
                  return ListTile(
                    title: Text(result),
                    onTap: () {


    if (catNames.contains(result)) {
    int index = catNames.indexOf(result);
    buildIconWithExamples(context)[index].onPressed!();
    } else if (examples1.contains(result)) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => CourseScreen(result)));
    } else if (examples2.contains(result)) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => OpportunitiesPage()));
    } else if (examples3.contains(result)) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    ClassesPage(locale: Locale('ar', 'AE'))));
    } else if (examples4.contains(result)) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    BookStorePage(locale: Locale('ar', 'AE'))));
    }        }

                  );
                }).toList(),
              ),
            ),
          if (noResultsFound)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                LocaleData.body101.getString(context),
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            ),
          // Displaying icons with examples in a vertical layout

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: buildIconWithExamples(context).map((iconWithExamples) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(iconWithExamples.icon,
                                size: 40, color: Colors.amber),
                            const SizedBox(width: 10),
                            Text(iconWithExamples.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TextButton(
                          onPressed: iconWithExamples.onPressed,
                          child: Text(LocaleData.body7.getString(context),
                              style: const TextStyle(color: Colors.blueAccent)),
                        ),
                      ],
                    ),
                    Column(
                      children: iconWithExamples.examples.map((example) {
                        return GestureDetector(
                          onTap: () {
                            if (example == 'ElectroRAI' ||
                                example == 'ElectroRAI' ||
                                example == 'إلكتروراي' ||
                                example == 'إلكتروراي' ||
                                example == 'Design' ||
                                example == 'Marketing' ||
                                example == 'تصميم' ||
                                example == 'تسويق') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CourseScreen(example)));
                            } else  if (example == 'Machine Learning Engineer' ||
                                example == 'Java Developer' ||
                                example == 'مهندس تعلم الآلة' ||
                                example == 'مطور جافا') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OpportunitiesPage()));
                            } else  if (example == 'Moby Dick' ||
                                example == 'Great gatsby' ||
                                example == 'موبي ديك' ||
                                example == 'جاتسبي العظيم') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookStorePage(
                                          locale: Locale('ar', 'AE'))));
                            }


                          },

                          child: Text(example),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20), // Space between icons
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: _currentLocale == 'en' ? "Home" : "الرئيسية",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: _currentLocale == 'en' ? "Wishlist" : "قائمة الرغبات"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: _currentLocale == 'en' ? "Account" : "الحساب"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
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

class IconWithExamples {
  final IconData icon;
  final String title;
  final List<String> examples;
  final VoidCallback? onPressed;

  IconWithExamples(
      {required this.icon,
      required this.title,
      required this.examples,
      this.onPressed});
}

class WavyFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    Path path = Path();

    // Create a wave effect using sine function for a smooth curve
    for (double i = 0; i <= size.width; i++) {
      double waveHeight = sin(i / size.width * 2 * pi) * 5;
      path.lineTo(i, size.height / 2 + waveHeight);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

