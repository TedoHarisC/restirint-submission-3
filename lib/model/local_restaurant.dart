import 'dart:convert';

import 'package:restirint/model/menu.dart';

class LocalRestaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final Menus menus;

  LocalRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory LocalRestaurant.fromJson(restaurant) => LocalRestaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'],
        menus: Menus.fromJson(restaurant['menus']),
      );
}

List<LocalRestaurant> parseRestaurants(json) {
  if (json == null) {
    return [];
  }

  final Map parsedMap = jsonDecode(json);
  final List parsed = parsedMap['restaurants'];
  return parsed.map((json) => LocalRestaurant.fromJson(json)).toList();
}
