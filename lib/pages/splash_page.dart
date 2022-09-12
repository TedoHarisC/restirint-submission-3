import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restirint/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () async {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrangeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img_logo.png', width: 140, height: 140),
            const SizedBox(height: 20),
            Text(
              'Ristirint',
              style: whiteTextStyle.copyWith(
                fontSize: 34,
                fontWeight: regular,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'your best restaurant consultant partner',
              style: whiteTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: regular,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
