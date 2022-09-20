import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restirint/model/customer_review.dart';
import 'package:restirint/model/detail_restaurant.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/services/restaurant_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantsProvider extends ChangeNotifier {
  final RestaurantService restaurantService;

  RestaurantsProvider({required this.restaurantService});

  ResponseLocalRestaurant? _dataRestaurant;
  late ResponseLocalRestaurantDetail _dataDetailRestaurant;
  late ResultState _state;
  String _message = "";

  String get message => _message;
  ResponseLocalRestaurant get restaurants =>
      _dataRestaurant ??
      ResponseLocalRestaurant(
          error: false,
          message: '',
          count: 0,
          restaurants: <LocalRestaurant>[].toList());
  ResponseLocalRestaurantDetail get restaurant => _dataDetailRestaurant;
  ResultState get state => _state;

  Future _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await restaurantService.getRestaurantList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _dataRestaurant = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          "Ups, Koneksi kamu terputus nih. Silahkan pastikan kalian konek dengan internet dan lakukan reload aplikasi ya";
    }
  }

  Future _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await restaurantService.getRestaurantDetail(id);
      if (response.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _dataDetailRestaurant = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          "Ups, Koneksi kamu terputus nih. Silahkan pastikan kalian konek dengan internet dan lakukan reload aplikasi ya";
    }
  }

  Future postReview(CustomerReview review) async {
    try {
      final response = await restaurantService.addReview(review);
      if (!response.error) {
        _fetchDetailRestaurant(review.id!);
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          "Ups, Koneksi kamu terputus nih. Silahkan pastikan kalian konek dengan internet dan lakukan reload aplikasi ya";
    }
  }

  RestaurantsProvider getAllRestaurant() {
    _fetchAllRestaurant();
    return this;
  }

  RestaurantsProvider getDetailRestaurant(String id) {
    _fetchDetailRestaurant(id);
    return this;
  }
}
