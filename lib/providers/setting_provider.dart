import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restirint/utils/background_service.dart';
import 'package:restirint/utils/datetime_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  static const String notificationPrefs = 'notification';

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(notificationPrefs, _isScheduled);
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      bool result = false;
      prefs.setBool(notificationPrefs, result);
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
