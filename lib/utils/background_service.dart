import 'dart:ui';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:restirint/main.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/services/restaurant_service.dart';
import 'package:restirint/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }
  //BackgroundService._createObject();

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }
    final NotificationHelper notificationHelper = NotificationHelper();
    LocalRestaurant result = await RestaurantService().getRandomRestaurant();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    if (kDebugMode) {
      print('Execute some process');
    }
  }
}
