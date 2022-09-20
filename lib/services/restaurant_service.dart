import 'dart:convert';

import 'package:restirint/model/customer_review.dart';
import 'package:restirint/model/detail_restaurant.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restirint/utils/config.dart';

class RestaurantService {
  Future<ResponseLocalRestaurant> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse("${baseAPIUrl}list"));
      if (response.statusCode == 200) {
        return ResponseLocalRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception("Gagal untuk mendapatkan data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseLocalRestaurantDetail> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse("${baseAPIUrl}detail/$id"));
      if (response.statusCode == 200) {
        return ResponseLocalRestaurantDetail.fromJson(
            json.decode(response.body));
      } else {
        throw Exception("Gagal untuk mendapatkan data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseSearchLocalRestaurant> searchRestaurant(query) async {
    try {
      final response =
          await http.get(Uri.parse("${baseAPIUrl}search?q=$query"));

      if (response.statusCode == 200) {
        return ResponseSearchLocalRestaurant.fromJson(
            json.decode(response.body));
      } else {
        throw Exception("Gagal untuk mendapatkan data search");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseCustomerReview> addReview(CustomerReview review) async {
    var reviewData = jsonEncode(review.toJson());
    try {
      final response = await http.post(
        Uri.parse("${baseAPIUrl}review"),
        body: reviewData,
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return ResponseCustomerReview.fromJson(
          json.decode(response.body),
        );
      } else {
        throw Exception("Gagal untuk mengirim data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
