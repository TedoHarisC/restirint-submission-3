import 'package:flutter/material.dart';
import 'package:restirint/theme.dart';

class MenuList extends StatelessWidget {
  final String name;
  final String typeMenu;

  const MenuList({Key? key, required this.name, this.typeMenu = 'food'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: halfMargin),
      child: Row(
        children: [
          (typeMenu == "food")
              ? Image.asset(
                  'assets/icon_food.png',
                  width: 15,
                  height: 15,
                )
              : Image.asset(
                  'assets/icon_drink.png',
                  width: 15,
                  height: 15,
                ),
          const SizedBox(width: 10),
          Text(
            name,
          ),
        ],
      ),
    );
  }
}
