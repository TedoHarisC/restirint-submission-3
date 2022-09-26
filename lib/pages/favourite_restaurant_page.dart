import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/providers/favorite_restaurant_provider.dart';
import 'package:restirint/theme.dart';
import 'package:restirint/widgets/bottom_nav_bar.dart';
import 'package:restirint/widgets/restaurant_tile.dart';
import 'package:restirint/widgets/shimmer/list_skeleton_item.dart';

class FavouriteRestaurantPage extends StatefulWidget {
  const FavouriteRestaurantPage({super.key});

  @override
  State<FavouriteRestaurantPage> createState() =>
      _FavouriteRestaurantPageState();
}

class _FavouriteRestaurantPageState extends State<FavouriteRestaurantPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget placeholderWhenLoading() {
      return Column(
        children: const [
          ListSkeletonItem(),
          SizedBox(height: 20),
          ListSkeletonItem(),
          SizedBox(height: 20),
          ListSkeletonItem(),
          SizedBox(height: 20),
          ListSkeletonItem(),
          SizedBox(height: 20),
          ListSkeletonItem(),
          SizedBox(height: 20),
          ListSkeletonItem(),
          SizedBox(height: 20),
        ],
      );
    }

    Widget listAllFavouriteRestaurantStream() {
      return ChangeNotifierProvider(
        create: (_) => FavoriteRestaurantProvider().getAllFavouriteRestaurant(),
        child: Consumer<FavoriteRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultFavoriteState.loading) {
              return placeholderWhenLoading();
            } else if (state.state == ResultFavoriteState.hasData) {
              List<LocalRestaurant> resultSearch = state.result;

              return Column(
                children: resultSearch.map((item) {
                  return RestaurantTile(dataRestaurant: item);
                }).toList(),
              );
            } else if (state.state == ResultFavoriteState.error) {
              return Center(
                child: Text(
                  state.message,
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state.state == ResultFavoriteState.noData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/img_no_favourite_content.png',
                      width: 299,
                      height: 299,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Belum ada data restaurant yang jadi favourite kamu nih, \nYuk mulai tambahkan dengan menekan tombol like di Halaman Detail Restaurant.',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/img_no_favourite_content.png',
                      width: 299,
                      height: 299,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        'Belum ada data restaurant yang tersedia',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      );
    }

    Widget content() {
      return SafeArea(
        child: RefreshIndicator(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(halfMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Favourite Restaurant List',
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 30),
                  listAllFavouriteRestaurantStream(),
                ],
              ),
            ),
          ),
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 3),
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kGreenColor,
                    content: const Text('Yeay data berhasil diperbarui.'),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      body: content(),
      bottomNavigationBar: const BottomNavBar(
        selected: "favourite",
      ),
    );
  }
}
