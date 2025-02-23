import 'package:flutter/material.dart';
import 'package:news_app/constants/text_style.dart';

class HeadingRow {
  static Widget row({required String heading, required TextStyle style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: style,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "See all",
            style: MTextStyle.mStyle(
              fontSize: 15,
              fontColor: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
