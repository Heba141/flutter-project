import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'home_page.dart';
import 'locales.dart';

class BookStorePage extends StatefulWidget {
  final Locale locale;

  BookStorePage({required this.locale}); // Accept locale in constructor

  @override
  _BookStorePageState createState() => _BookStorePageState();
}

class _BookStorePageState extends State<BookStorePage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  @override
  //void initState(){
    //super.initState();


 // }
  final List<Map<String, String>> books = [
    {
      "title": "Great Gatsby",
      "cover": "lib/images/1024px-The_Great_Gatsby_Cover_1925_Retouched.jpg",
      "file": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf" // Internet URL
    },
    {
      "title": "Moby Dick",
      "cover": "lib/images/moby_dick.jpg",
      "file": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
    },
    {
      "title": "GAME",
      "cover": "lib/images/l.png",
      "file": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
    },
  ];


  List<Map<String, String>> filteredBooks = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    filteredBooks = books; // Initialize with all books
    _flutterLocalization =FlutterLocalization.instance;
    _currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }

  void filterBooks(String query) {
    final filtered = books.where((book) {
      return book['title']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredBooks = filtered;
      searchText = query; // Update the search text
    });
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
        //title: Text( LocaleData.body4.getString(context),
          //  style: TextStyle(fontWeight: FontWeight.bold)),
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
            // Search box
            TextField(
              decoration: InputDecoration(
                labelText:context.formatString(LocaleData.body5, ["heba"]),

        border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: filterBooks,
            ),
            SizedBox(height: 16.0), // Space between search box and grid
            // Display books or a message if no books are found
            Expanded(
              child: filteredBooks.isNotEmpty
                  ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 books per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.7, // Aspect ratio for book cards
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  return BookCard(
                    title: filteredBooks[index]['title']!,
                    coverImage: filteredBooks[index]['cover']!,
                    filePath: filteredBooks[index]['file']!,
                    locale: widget.locale, // Pass locale to BookCard
                  );
                },
              )
                  : Center(
                child: Text(
                  LocaleData.body102.getString(context),
                  style: TextStyle(fontSize: 18, color: Colors.red),
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

// Custom widget for each book card
class BookCard extends StatelessWidget {
  final String title;
  final String coverImage;
  final String filePath;
  final Locale locale;

  BookCard({
    required this.title,
    required this.coverImage,
    required this.filePath,
    required this.locale, // Accept locale in constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to PDF Viewer when a book is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(filePath: filePath),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  coverImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            // Book title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PDF Viewer page to display the selected book
class PDFViewerPage extends StatelessWidget {
  final String filePath;

  PDFViewerPage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
       // title: Text( LocaleData.body100.getString(context),
         //   style: TextStyle(fontWeight: FontWeight.bold)),
        //backgroundColor: Colors.blueAccent,
      ),
      body: PDFView(
        filePath: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf, // Use the URL provided when calling PDFViewerPage',
        autoSpacing: true,
        enableSwipe: true,
        swipeHorizontal: true,
        fitPolicy: FitPolicy.BOTH,

      ),
    );
  }
}
