import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/services/restaurant_service.dart';

enum SearchResultState { loading, noData, hasData, error }

class SearchRestaurantsProvider extends ChangeNotifier {
  final RestaurantService restaurantService;

  SearchRestaurantsProvider({required this.restaurantService});

  ResponseSearchLocalRestaurant? _dataSearchRestaurant;

  late SearchResultState _state;
  String _message = "";

  String get message => _message;
  SearchResultState get state => _state;
  ResponseSearchLocalRestaurant get searchResultRestaurant =>
      _dataSearchRestaurant ??
      ResponseSearchLocalRestaurant(
          error: false, founded: 0, restaurants: <LocalRestaurant>[].toList());

  Future _fetchSearchRestaurant(String query) async {
    try {
      _state = SearchResultState.loading;
      notifyListeners();
      final response = await restaurantService.searchRestaurant(query);

      if (response.error) {
        _state = SearchResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data ditemukan';
      } else {
        _state = SearchResultState.hasData;
        notifyListeners();
        return _dataSearchRestaurant = response;
      }
    } catch (e) {
      _state = SearchResultState.error;
      notifyListeners();
      return _message =
          "Ups, Koneksi kamu terputus nih. Silahkan pastikan kalian konek dengan internet dan lakukan reload aplikasi ya";
    }
  }

  SearchRestaurantsProvider searchRestaurant(String query) {
    _fetchSearchRestaurant(query);
    return this;
  }
}
