import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = const Color(0xffC74E5B);
Color kSecondaryColor = const Color(0xffD9AC7F);
Color kGreenColor = const Color(0xff24C690);
Color kRedColor = const Color(0xffFF576B);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

double defaultMargin = 20.0;
double halfMargin = defaultMargin / 2;

TextStyle primaryTextStyle = GoogleFonts.nunito(
  color: kPrimaryColor,
);

TextStyle secondaryTextStyle = GoogleFonts.nunito(
  color: kSecondaryColor,
);

TextStyle greenTextStyle = GoogleFonts.nunito(
  color: kGreenColor,
);

TextStyle redTextStyle = GoogleFonts.nunito(
  color: kRedColor,
);
