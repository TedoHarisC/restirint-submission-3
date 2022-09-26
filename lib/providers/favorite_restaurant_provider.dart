import 'package:flutter/foundation.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/utils/db_helper.dart';

enum ResultState { loading, noData, hasData, error }

class FavoriteRestaurantProvider extends ChangeNotifier {
  late DbHelper _dbHelper;
  late ResultState _state;
  String _message = "";

  late List<LocalRestaurant> _result;

  FavoriteRestaurantProvider() {
    _dbHelper = DbHelper();
    _getAllFavouriteRestaurant();
  }

  Future _getAllFavouriteRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await _dbHelper.getFavoriteRestaurant();
      if (response.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _result = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          "Ups, Koneksi kamu terputus nih. Silahkan pastikan kalian konek dengan internet dan lakukan reload aplikasi ya";
    }
  }

  Future<void> addFavouriteRestaurant(LocalRestaurant restaurant) async {
    await _dbHelper.insertFavoriteRestaurant(restaurant);
    _getAllFavouriteRestaurant();
  }

  void deleteNote(LocalRestaurant restaurant) async {
    await _dbHelper.deleteFavoriteRestaurant(restaurant);
    _getAllFavouriteRestaurant();
  }

  Future<bool> getFavouriteRestaurantById(String id) async {
    return await _dbHelper.checkFavoriteStatus(id);
  }
}
