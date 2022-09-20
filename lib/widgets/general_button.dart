import 'package:flutter/material.dart';
import 'package:restirint/theme.dart';

class GeneralButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String text;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;

  const GeneralButton(
      {Key? key,
      this.width = 80,
      this.height = 32,
      this.borderRadius = 26,
      required this.text,
      this.fontSize = 10,
      required this.textColor,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontSize: fontSize,
            fontWeight: semiBold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
