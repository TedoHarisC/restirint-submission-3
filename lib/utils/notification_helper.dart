import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/utils/navigation_helper.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    // var initializationSettingsIOS = IOSInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse payload) async {
      final result = payload.payload;
      if (result != null) {
        // ignore: avoid_print
        print('notification payload: $result');
      }
      selectNotificationSubject.add(result ?? '');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      LocalRestaurant restaurant) async {
    var channelId = "1";
    var channelName = "channel_1";
    var channelDescription = "ristirint channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    //var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    var titleNotification = "<b>Visit Restaurant ini Yuks</b>";
    var nameRestaurant = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, nameRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurant.toJsonForSql()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        LocalRestaurant restaurant =
            LocalRestaurant.fromJson(json.decode(payload));
        Navigation.intentWithData(route, restaurant);
      },
    );
  }
}
