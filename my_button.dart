import 'package:flutter/material.dart';
import 'package:itqan/home_page.dart';
import 'package:itqan/secondscreen.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: TextButton(
            child: const Text("Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>  HomePage(isArabic: true,locale:null), // Ensure HomeScreen is a Widget

                )
              );
            },
          ),
        ),
      ),
    );
  }
}
