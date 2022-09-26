import 'dart:convert';

import 'package:restirint/model/menu.dart';
import 'package:restirint/utils/config.dart';

class LocalRestaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final Menus? menus;

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
        menus: restaurant["menus"] == null
            ? null
            : Menus.fromJson(restaurant['menus']),
      );

  String getSmallResolutionPicture() => smallResolutionUrl + pictureId;
  String getMediumResolutionPicture() => mediumResolutionUrl + pictureId;
  String getLargeResolutionPicture() => largeResolutionUrl + pictureId;

  Map<String, dynamic> toJsonForSql() {
    return {
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }
}

List<LocalRestaurant> parseRestaurants(json) {
  if (json == null) {
    return [];
  }

  final Map parsedMap = jsonDecode(json);
  final List parsed = parsedMap['restaurants'];
  return parsed.map((json) => LocalRestaurant.fromJson(json)).toList();
}

class ResponseLocalRestaurant {
  final bool error;
  final String message;
  final int count;
  final List<LocalRestaurant> restaurants;

  ResponseLocalRestaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory ResponseLocalRestaurant.fromJson(Map<String, dynamic> json) =>
      ResponseLocalRestaurant(
          error: json["error"],
          message: json["message"],
          count: json["count"],
          restaurants: List<LocalRestaurant>.from(
              json['restaurants'].map((x) => LocalRestaurant.fromJson(x))));
}

class ResponseSearchLocalRestaurant {
  final bool error;
  final int founded;
  final List<LocalRestaurant> restaurants;

  ResponseSearchLocalRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory ResponseSearchLocalRestaurant.fromJson(Map<String, dynamic> json) =>
      ResponseSearchLocalRestaurant(
          error: json["error"],
          founded: json["founded"],
          restaurants: List<LocalRestaurant>.from(
              json['restaurants'].map((x) => LocalRestaurant.fromJson(x))));
}
