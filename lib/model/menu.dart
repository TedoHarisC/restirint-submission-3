import 'package:restirint/model/drinks.dart';
import 'package:restirint/model/foods.dart';

class Menus {
  final List<Foods> foods;
  final List<Drinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(menu) => Menus(
        foods:
            List<Foods>.from(menu['foods'].map((item) => Foods.fromJson(item))),
        drinks: List<Drinks>.from(
            menu['drinks'].map((item) => Drinks.fromJson(item))),
      );
}
