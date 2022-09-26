import 'package:flutter/material.dart';
import 'package:restirint/pages/favourite_restaurant_page.dart';
import 'package:restirint/pages/home_page.dart';
import 'package:restirint/theme.dart';

class BottomNavBar extends StatefulWidget {
  final String selected;

  const BottomNavBar({
    super.key,
    required this.selected,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
      // print(_selectedNavbar);

      if (_selectedNavbar == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else if (_selectedNavbar == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FavouriteRestaurantPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: kWhiteColor),
      child: Container(
        width: MediaQuery.of(context).size.width - (2 * defaultMargin),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedNavbar,
            onTap: _changeSelectedNavBar,
            selectedItemColor: kOrangeColor,
            items: [
              BottomNavigationBarItem(
                icon: (widget.selected == "home")
                    ? Image.asset(
                        'assets/icon_menu_home_active.png',
                        width: 22,
                        height: 22,
                      )
                    : Image.asset(
                        'assets/icon_menu_home.png',
                        width: 20,
                        height: 20,
                      ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: (widget.selected == "favourite")
                    ? Image.asset(
                        'assets/icon_menu_favorite_active.png',
                        width: 22,
                        height: 22,
                      )
                    : Image.asset(
                        'assets/icon_menu_favorite.png',
                        width: 22,
                        height: 22,
                      ),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
