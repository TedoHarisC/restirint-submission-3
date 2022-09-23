import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/providers/restaurant_provider.dart';
import 'package:restirint/services/restaurant_service.dart';
import 'package:restirint/theme.dart';
import 'package:restirint/widgets/restaurant_tile.dart';
import 'package:restirint/widgets/search_tile.dart';
import 'package:restirint/widgets/shimmer/list_skeleton_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController(text: '');
  Widget listRestaurantStream = Container();

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

  Widget listSearchRestaurantStream(String query) {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return placeholderWhenLoading();
        } else if (state.state == ResultState.hasData) {
          if (query == "") {
            List<LocalRestaurant> result = state.restaurants.restaurants;

            return Column(
              children: result.map((item) {
                return RestaurantTile(dataRestaurant: item);
              }).toList(),
            );
          } else {
            List<LocalRestaurant> resultSearch =
                state.searchResultRestaurant.restaurants;

            return Column(
              children: resultSearch.map((item) {
                return RestaurantTile(dataRestaurant: item);
              }).toList(),
            );
          }
        } else if (state.state == ResultState.error) {
          return Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/img_no_connection.png',
                  width: 299,
                  height: 299,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  state.message,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
              'Belum ada data restaurant yang tersedia',
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }

  Widget listAllRestaurantStream() {
    return ChangeNotifierProvider(
      create: (_) => RestaurantsProvider(restaurantService: RestaurantService())
          .getAllRestaurant(""),
      child: Consumer<RestaurantsProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return placeholderWhenLoading();
          } else if (state.state == ResultState.hasData) {
            List<LocalRestaurant> resultSearch = state.restaurants.restaurants;

            return Column(
              children: resultSearch.map((item) {
                return RestaurantTile(dataRestaurant: item);
              }).toList(),
            );
          } else if (state.state == ResultState.error) {
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
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(
                'Belum ada data restaurant yang tersedia',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Center(
              child: Text(
                'Belum ada data restaurant yang tersedia',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    listRestaurantStream = listAllRestaurantStream();
  }

  @override
  Widget build(BuildContext context) {
    Widget headerContent() {
      return Container(
        width: MediaQuery.of(context).size.width - (2 * defaultMargin),
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/user_icon.png',
                  width: 44,
                  height: 44,
                ),
                const SizedBox(width: 15),
                Text(
                  'Welcome !',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/icon_notification.png',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Best Recommendation Restaurant',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Just for you !',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 30),
            SearchTile(
              searchController: searchController,
              hint: 'Cari Nama Restaurant Favorit mu',
              onChange: (value) {
                setState(() {
                  Provider.of<RestaurantsProvider>(context, listen: false)
                      .getAllRestaurant(value);

                  listRestaurantStream = listSearchRestaurantStream(value);
                });
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    }

    Widget content() {
      return RefreshIndicator(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(halfMargin),
            child: Column(
              children: [
                headerContent(),
                listRestaurantStream,
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
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: content(),
      ),
    );
  }
}
