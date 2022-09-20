import 'package:restirint/model/categories.dart';
import 'package:restirint/model/customer_review.dart';
import 'package:restirint/model/menu.dart';
import 'package:restirint/utils/config.dart';

class DetailRestaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final List<Categories>? categories;
  final Menus? menus;
  final List<CustomerReview>? customerReviews;

  DetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory DetailRestaurant.fromJson(restaurant) => DetailRestaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'],
        categories: List<Categories>.from((restaurant['categories'])
            .map((item) => Categories.fromJson(item))),
        menus: restaurant["menus"] == null
            ? null
            : Menus.fromJson(restaurant['menus']),
        customerReviews: List<CustomerReview>.from(
            (restaurant['customerReviews'] as List)
                .map((item) => CustomerReview.fromJson(item))
                .where((review) => review.name.isNotEmpty)),
      );

  String getSmallResolutionPicture() => smallResolutionUrl + pictureId;
  String getMediumResolutionPicture() => mediumResolutionUrl + pictureId;
  String getLargeResolutionPicture() => largeResolutionUrl + pictureId;
}

class ResponseLocalRestaurantDetail {
  final bool error;
  final String message;
  final DetailRestaurant restaurant;

  ResponseLocalRestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory ResponseLocalRestaurantDetail.fromJson(Map<String, dynamic> json) =>
      ResponseLocalRestaurantDetail(
          error: json["error"],
          message: json["message"],
          restaurant: DetailRestaurant.fromJson(json["restaurant"]));
}
