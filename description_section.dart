import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../locales.dart';

class DescriptionSection extends StatefulWidget {
  DescriptionSection({super.key});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();

}

class _DescriptionSectionState extends State<DescriptionSection> {
 // _DescriptionSectionElement(DescriptionSection widget) : super(widget);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            LocaleData.body98.getString(context),

            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.timer,
                color: Colors.blueAccent,
                size: 32,
              ),
              SizedBox(width: 5),
              Text(
                LocaleData.body99.getString(context),

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.blueAccent,
                size: 32,
              ),
              SizedBox(width: 5),
              Text(
                "4.5",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
