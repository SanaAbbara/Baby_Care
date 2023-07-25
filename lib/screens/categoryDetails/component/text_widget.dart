// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  Color? fontcolor;
  double? fontsize;
  String? text;
  double? width;
  TextWidget({
    this.width,
    this.fontcolor,
    this.fontsize,
    this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text!,
        style: TextStyle(
            color: fontcolor, fontSize: fontsize, fontWeight: FontWeight.w400),
      ),
    );
  }
}
