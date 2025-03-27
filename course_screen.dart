import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/locales.dart';
import 'package:itqan/widgets/description_section.dart';
import 'package:itqan/widgets/videos_player_page.dart';


class CourseScreen extends StatefulWidget{
  String img;
  CourseScreen(this.img, {super.key, });
 @override
  State<CourseScreen> createState() => _CourseScreenState();

}
class _CourseScreenState extends State<CourseScreen> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  @override
  void initState(){
    super.initState();
    _flutterLocalization =FlutterLocalization.instance;
    _currentLocale =_flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }
  bool isVideosPlayerPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.img,
          style: const TextStyle(
            fontWeight: FontWeight.bold,

          ),

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
        //actions: const [
          //Padding(
            //padding: EdgeInsets.only(right: 10),
            //child: Icon(
              //Icons.notifications,
              //size: 28,
              ///color: Colors.white,
            //),

          //),
        //],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFF5F3FF),
                image: DecorationImage(
                  image: AssetImage("lib/images/${widget.img}.png"
                  ),
                ),

              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,

                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.blueAccent,
                    size: 45,

                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "${widget.img}",

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,

              ),
            ),
            const SizedBox(height: 5),
             Text(
              LocaleData.body74.getString(context),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              LocaleData.body72.getString(context),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(10),

              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  Material(

                    color: isVideosPlayerPage ? Colors.blueAccent : Colors.purpleAccent
                        .withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => VideosPlayerPage(),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 35),
                        child:  Text(
                          LocaleData.body75.getString(context),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),

                      ),
                                   ),
                  ),
                  Material(
                    color: isVideosPlayerPage ? Colors.blueAccent.withOpacity(0.6) :
                    Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isVideosPlayerPage = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),

                        color: Colors.blueAccent,
                        child:  Text(
                          LocaleData.body76.getString(context),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],

              ),

            ),
            const SizedBox(height: 20),
            isVideosPlayerPage ? VideosPlayerPage() : DescriptionSection(),
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
