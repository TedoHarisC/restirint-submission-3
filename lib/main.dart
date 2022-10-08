import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restirint/pages/favourite_restaurant_page.dart';
import 'package:restirint/pages/home_page.dart';
import 'package:restirint/pages/setting_page.dart';
import 'package:restirint/pages/splash_page.dart';
import 'package:restirint/providers/favorite_restaurant_provider.dart';
import 'package:restirint/providers/restaurant_provider.dart';
import 'package:restirint/providers/setting_provider.dart';
import 'package:restirint/services/restaurant_service.dart';
import 'package:restirint/utils/background_service.dart';
import 'package:restirint/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantsProvider(restaurantService: RestaurantService()),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const HomePage(),
          '/favourite': (context) => const FavouriteRestaurantPage(),
          '/setting': (context) => const SettingPage(),
        },
      ),
    );
  }
}
