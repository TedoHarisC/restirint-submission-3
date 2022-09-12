import 'package:flutter/material.dart';
import 'package:restirint/model/local_restaurant.dart';
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

  List<LocalRestaurant> _foundRequests = [];

  Future<void> setAllDataRestaurant() async {
    var result = await DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json');

    final List<LocalRestaurant> restaurants = parseRestaurants(result);

    setState(() {
      _foundRequests = restaurants;
    });
  }

  void _runFilterRequest(
    String enteredKeyword,
    List<LocalRestaurant> all,
  ) {
    List<LocalRestaurant> results = [];
    if (enteredKeyword.isEmpty) {
      results = all;
    } else {
      results = all
          .where((request) => (request.name)
              .toLowerCase()
              .startsWith(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundRequests = results;
    });
  }

  @override
  void initState() {
    super.initState();
    setAllDataRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    Widget headerContent(List<LocalRestaurant> restaurants) {
      return Container(
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
            ),
            Text(
              'Just for you !',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 30),
            SearchTile(
              searchController: searchController,
              hint: 'Cari Nama Restaurant Favorit mu',
              onChange: (value) {
                _runFilterRequest(value, restaurants);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    }

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

    Widget content() {
      return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<LocalRestaurant> restaurants =
              parseRestaurants(snapshot.data);

          if (snapshot.connectionState == ConnectionState.done) {
            return RefreshIndicator(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      headerContent(restaurants),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _foundRequests.length,
                          itemBuilder: (context, index) {
                            return (_foundRequests.isNotEmpty)
                                ? RestaurantTile(
                                    dataRestaurant: _foundRequests[index])
                                : Center(
                                    child: Text(
                                      'Belum ada data restaurant yang tersedia',
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: semiBold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                          },
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              onRefresh: () {
                return Future.delayed(
                  const Duration(seconds: 3),
                  () {
                    setAllDataRestaurant();

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
          } else {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    headerContent(restaurants),
                    placeholderWhenLoading(),
                  ],
                ),
              ),
            );
          }
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
