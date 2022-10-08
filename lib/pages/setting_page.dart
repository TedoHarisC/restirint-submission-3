import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restirint/providers/setting_provider.dart';
import 'package:restirint/theme.dart';
import 'package:restirint/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<void> getDataValueSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool("notification") ?? false;

    // ignore: use_build_context_synchronously
    await Provider.of<SettingProvider>(context, listen: false)
        .scheduledNews(value);
  }

  @override
  void initState() {
    getDataValueSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Restaurant Notification",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
              Consumer<SettingProvider>(builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      // customDialog(context);
                    } else {
                      scheduled.scheduledNews(value);
                    }
                  },
                );
              }),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(child: content()),
      bottomNavigationBar: const BottomNavBar(
        selected: "setting",
      ),
    );
  }
}
