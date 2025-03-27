import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';
import 'locales.dart';

// Opportunities Page
class OpportunitiesPage extends StatefulWidget {
  const OpportunitiesPage({super.key});

  @override
  _OpportunitiesPageState createState() => _OpportunitiesPageState();
}

class _OpportunitiesPageState extends State<OpportunitiesPage> {
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
    jobOpportunities = _currentLocale == 'ar' ? arabicJobOpportunities : englishJobOpportunities;
  }

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
          //LocaleData.body73.getString(context),
          //style: TextStyle(
            //color: Colors.white,
           // fontWeight: FontWeight.bold,
          //),
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
        elevation: 5,

      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: jobOpportunities.length,
          itemBuilder: (context, index) {
            final job = jobOpportunities[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.work_outline,
                    color: Colors.orangeAccent,
                  ),
                  title: Text(
                    job['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    '${job['company']} - ${job['location']}',
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OpportunitiesDetail(job: job),
                      ),
                    );
                  },
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
    if (value == "en") {
      _flutterLocalization.translate("en");
      jobOpportunities = englishJobOpportunities;
    } else if (value == "ar") {
      _flutterLocalization.translate("ar");
      jobOpportunities = arabicJobOpportunities;
    } else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}

class OpportunitiesDetail extends StatelessWidget {
  final Map<String, String> job;

  OpportunitiesDetail({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          job['title']!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['title']!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Company: ${job['company']}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Location: ${job['location']}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  LocaleData.body79.getString(context),

                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 24),
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      launch(job['applicationUrl']!);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      child: Text(
                        LocaleData.body81.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      child: Text(
                        LocaleData.body82.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
