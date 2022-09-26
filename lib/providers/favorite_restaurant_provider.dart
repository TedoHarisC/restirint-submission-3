import 'package:flutter/foundation.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/utils/db_helper.dart';

enum ResultFavoriteState {
  loading,
  noData,
  hasData,
  error,
  isFavorite,
  isNotFavorite
}

class FavoriteRestaurantProvider extends ChangeNotifier {
  late DbHelper _dbHelper;
  late ResultFavoriteState _state;
  String _message = "";

  late List<LocalRestaurant> _result;

  FavoriteRestaurantProvider() {
    _dbHelper = DbHelper();
    _getAllFavouriteRestaurant();
  }

  ResultFavoriteState get state => _state;
  String get message => _message;
  List<LocalRestaurant> get result => _result;

  Future _getAllFavouriteRestaurant() async {
    try {
      _state = ResultFavoriteState.loading;
      notifyListeners();
      final response = await _dbHelper.getFavoriteRestaurant();
      if (response.isEmpty) {
        _state = ResultFavoriteState.noData;
        notifyListeners();
        return _message = 'Tidak ada data ditemukan';
      } else {
        _state = ResultFavoriteState.hasData;
        notifyListeners();
        return _result = response;
      }
    } catch (e) {
      _state = ResultFavoriteState.error;
      notifyListeners();
      return _message =
          "Ups, Koneksi kamu terputus nih. Silahkan pastikan kalian konek dengan internet dan lakukan reload aplikasi ya";
    }
  }

  Future<void> addFavouriteRestaurant(LocalRestaurant restaurant) async {
    await _dbHelper.insertFavoriteRestaurant(restaurant);
  }

  void deleteFavoriteRestaurant(LocalRestaurant restaurant) async {
    await _dbHelper.deleteFavoriteRestaurant(restaurant);
  }

  Future<bool> getFavouriteRestaurantById(String id) async {
    final result = await _dbHelper.checkFavoriteStatus(id);
    if (result) {
      _state = ResultFavoriteState.isFavorite;
    } else {
      _state = ResultFavoriteState.isNotFavorite;
    }

    return result;
  }

  FavoriteRestaurantProvider getAllFavouriteRestaurant() {
    _getAllFavouriteRestaurant();
    return this;
  }
}
