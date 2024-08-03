// Flutter Package
import 'package:flutter/material.dart';

extension StringExtension on String {
  Color toColor() {
    String hexColor = replaceAll("#", "");

    return Color(int.parse("0xFF$hexColor"));
  }

  // To correct the TextOverflow.ellipsis
  // ** FOR SHOW PURPOSES ONLY ** - Like inside Text Widgets
  String tight() {
    return Characters(this)
        .replaceAll(Characters(' '), Characters('\u{000A0}'))
        .replaceAll(Characters('-'), Characters('\u{2011}'))
        .toString();
  }
}
