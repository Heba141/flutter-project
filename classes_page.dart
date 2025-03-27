import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'course_screen.dart';
import 'home_page.dart';

class ClassesPage extends StatefulWidget {
  final Locale locale;

  ClassesPage({required this.locale});

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
  }

  final List<String> classNames = [
    'Design',
    'Programming',
    'Languages',
    'Marketing',
    'Standards',
    'Machine Learning',
    'Digital Marketing',
    'Creative Writing',
    'Basics of Web Development',
    'Entrepreneurship',
    'Cognitive Psychology',
    'Business',
    'Cybersecurity',
    'Techniques',
  ];

  final List<String> arabicClassNames = [
    'تصميم',
    'برمجة',
    'لغات',
    'تسويق',
    'معايير',
    'تعلم الآلة',
    'التسويق الرقمي',
    'كتابة إبداعية',
    'أساسيات تطوير الويب',
    'ريادة الأعمال',
    'علم النفس المعرفي',
    'الأعمال',
    'أمن المعلومات',
    'تقنيات',
  ];

  final List<String> classDescriptions = [
    'Learn the principles of design and creativity.',
    'Dive into the world of coding and software development.',
    'Enhance your communication skills in various languages.',
    'Understand the fundamentals of marketing strategies.',
    'Explore standards and protocols in various industries.',
    'Get introduced to the world of AI and machine learning.',
    'Master digital marketing techniques and tools.',
    'Develop your writing skills in creative writing.',
    'Understand the basics of web technologies.',
    'Learn how to start and manage a successful business.',
    'Discover the psychological principles that drive behavior.',
    'Explore business concepts and management skills.',
    'Understand cybersecurity measures to protect information.',
    'Learn various techniques for personal and professional growth.',
  ];

  final List<String> arabicClassDescriptions = [
    'تعلم مبادئ التصميم والإبداع.',
    'استكشاف عالم البرمجة وتطوير البرمجيات.',
    'تعزيز مهارات الاتصال في اللغات المختلفة.',
    'فهم أساسيات استراتيجيات التسويق.',
    'استكشاف المعايير والبروتوكولات في مختلف الصناعات.',
    'التعرف على عالم الذكاء الاصطناعي وتعلم الآلة.',
    'إتقان تقنيات وأدوات التسويق الرقمي.',
    'تطوير مهارات الكتابة في الكتابة الإبداعية.',
    'فهم أساسيات تقنيات الويب.',
    'تعلم كيفية بدء وإدارة عمل ناجح.',
    'اكتشاف المبادئ النفسية التي تحرك السلوك.',
    'استكشاف مفاهيم الأعمال ومهارات الإدارة.',
    'فهم تدابير الأمن السيبراني لحماية المعلومات.',
    'تعلم تقنيات مختلفة للنمو الشخصي والمهني.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background to white
        title :
        Stack(
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
        //title: Text(
          //_currentLocale == 'ar' ? 'استكشاف الدروس' : 'Explore Classes',
          //style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //),
        actions: [
          DropdownButton(
            value: _currentLocale,
            items: const [
              DropdownMenuItem(value: "en", child: Text("English")),
              DropdownMenuItem(value: "ar", child: Text("Arabic")),
            ],
            onChanged: (value) {
              _setLocale(value);
            },
          ),
        ],
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white!, Colors.white!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            childAspectRatio: 1.5, // Height/width ratio of each grid item
            crossAxisSpacing: 10.0, // Space between columns
            mainAxisSpacing: 10.0, // Space between rows
          ),
          itemCount: classNames.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CourseScreen(_currentLocale == 'ar'
                              ? arabicClassNames[index]
                              : classNames[index]),
                    ),
                  );
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, size: 20, color: Colors.amber),
                      SizedBox(height: 10),
                      Text(
                        _currentLocale == 'ar'
                            ? arabicClassNames[index]
                            : classNames[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          _currentLocale == 'ar'
                              ? arabicClassDescriptions[index]
                              : classDescriptions[index],
                          style: TextStyle(
                              fontSize: 10, color: Colors.blueAccent[700]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _setLocale(String? value) {
    if (value == null) return;
    setState(() {
      _currentLocale = value;
    });
    _flutterLocalization.translate(value);
  }
}
