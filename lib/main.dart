import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restirint/pages/favourite_restaurant_page.dart';
import 'package:restirint/pages/home_page.dart';
import 'package:restirint/pages/splash_page.dart';
import 'package:restirint/providers/favorite_restaurant_provider.dart';
import 'package:restirint/providers/restaurant_provider.dart';
import 'package:restirint/services/restaurant_service.dart';

void main() {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const HomePage(),
          '/favourite': (context) => const FavouriteRestaurantPage(),
        },
      ),
    );
  }
}
