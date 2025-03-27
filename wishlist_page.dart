import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/category_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'locales.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
  }

  List<String> _wishlistItems = [];

  // English and Arabic categories
  List<String> _categoriesEn = [
    "Crown Prince Award",
    "King Abdullah II Center for Excellence",
    "National Center for Human Rights",
  ];

  List<String> _categoriesAr = [
    "جائزة ولي العهد",
    "مركز الملك عبد الله الثاني للتميز",
    "المركز الوطني لحقوق الإنسان",
  ];

  // TextEditingController to add new items
  final TextEditingController _controller = TextEditingController();

  Future<void> _loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _wishlistItems = prefs.getStringList('wishlist') ?? [];
    });
  }

  Future<void> _addItemToWishlist() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _wishlistItems.add(_controller.text);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('wishlist', _wishlistItems);
      _controller.clear();
    }
  }

  Future<void> _removeItemFromWishlist(int index) async {
    setState(() {
      _wishlistItems.removeAt(index);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('wishlist', _wishlistItems);
  }

  @override
  Widget build(BuildContext context) {
    // Select categories list based on the current language
    List<String> _categories = _currentLocale == 'en' ? _categoriesEn : _categoriesAr;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      //PreferredSize
       // (
      //  preferredSize: Size.fromHeight(56.0),
       // child:
      AppBar(
          //title: Text(
            //LocaleData.body8.getString(context),
            //style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          //),

          backgroundColor: Colors.white,// Set the background to white
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
          elevation: 2,

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
            )
          ],
        ),
      //),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField + Add Button Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: context.formatString(LocaleData.body12, ["Add to Wishlist"]),
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addItemToWishlist,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    backgroundColor: Colors.amber,
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Categories Title
            Text(
              LocaleData.body11.getString(context),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            // Categories List (switches between English and Arabic)
            ..._categories.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    side: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                  },
                  child: Text(
                    category,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            // Wishlist Items
            Expanded(
              child: ListView.builder(
                itemCount: _wishlistItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      leading: Icon(Icons.favorite, color: Colors.red),
                      title: Text(
                        _wishlistItems[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red.shade400),
                        onPressed: () => _removeItemFromWishlist(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "ar") {
      _flutterLocalization.translate("ar");
    }
    setState(() {
      _currentLocale = value;
    });
  }
}
