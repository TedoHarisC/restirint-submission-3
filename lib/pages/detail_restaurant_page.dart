import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restirint/model/detail_restaurant.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/pages/form_tambah_review.dart';
import 'package:restirint/providers/restaurant_provider.dart';
import 'package:restirint/services/restaurant_service.dart';
import 'package:restirint/theme.dart';
import 'package:restirint/widgets/menu_list.dart';
import 'package:restirint/widgets/review_tile.dart';

class DetailRestaurantPage extends StatefulWidget {
  final LocalRestaurant dataRestaurant;

  const DetailRestaurantPage({
    Key? key,
    required this.dataRestaurant,
  }) : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    RestaurantsProvider provider;

    Widget backButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 60,
              margin: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: defaultMargin,
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/icon_back.png',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 60,
              margin: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: defaultMargin,
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/icon_wishlist.png',
              ),
            ),
          ),
        ],
      );
    }

    Widget backgroundImage() {
      return Hero(
        tag: widget.dataRestaurant.pictureId,
        child: SizedBox(
          width: double.infinity,
          height: 436,
          child: Image.network(
            widget.dataRestaurant.getLargeResolutionPicture(),
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      );
    }

    Widget content(
        DetailRestaurant dataDetailRestaurant, RestaurantsProvider provider) {
      return SizedBox.expand(
        child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return NotificationListener(
                onNotification: (Notification notif) {
                  if (notif is ScrollEndNotification) {
                    if (notif.metrics.minScrollExtent == -1.0) {
                      setState(() {
                        isExpand = true;
                      });
                    } else {
                      setState(() {
                        isExpand = false;
                      });
                    }
                  }

                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 30),
                          padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin, vertical: 30),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Center(
                                child: Container(
                                  width: 140,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kBackgroundColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                dataDetailRestaurant.name,
                                style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(height: halfMargin),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon_location.png',
                                        width: 18,
                                        height: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        dataDetailRestaurant.city,
                                        style: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon_star.png',
                                        width: 18,
                                        height: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        dataDetailRestaurant.rating.toString(),
                                        style: greyTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Deskripsi',
                                style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(height: halfMargin),
                              Text(
                                dataDetailRestaurant.description,
                                style: blackTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: light,
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Menu Makanan',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Text(
                                    'See All',
                                    style: greyTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: defaultMargin),
                              Column(
                                children: dataDetailRestaurant.menus!.foods
                                    .map((item) {
                                  return MenuList(name: item.name);
                                }).toList(),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Menu Minuman',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Text(
                                    'See All',
                                    style: greyTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: defaultMargin),
                              Column(
                                children: dataDetailRestaurant.menus!.drinks
                                    .map((item) {
                                  return MenuList(name: item.name);
                                }).toList(),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Review Costumer',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FormTambahReview(
                                            idRestaurant:
                                                dataDetailRestaurant.id,
                                            provider: provider,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Tambah Review',
                                      style: greyTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: defaultMargin),
                              (dataDetailRestaurant.customerReviews != null)
                                  ? Column(
                                      children: dataDetailRestaurant
                                          .customerReviews!
                                          .map((item) {
                                        //return MenuList(name: item.name);
                                        return RevewTile(dataReview: item);
                                      }).toList(),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Belum ada review tersedia, Jadilah yang pertama untuk menilai resto ini',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: semiBold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ChangeNotifierProvider(create: (_) {
        provider = RestaurantsProvider(restaurantService: RestaurantService());
        return provider.getDetailRestaurant(widget.dataRestaurant.id);
      }, child: Consumer<RestaurantsProvider>(builder: ((context, value, _) {
        if (value.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.state == ResultState.hasData) {
          return Stack(children: [
            backgroundImage(),
            backButton(),
            content(value.restaurant.restaurant, value),
          ]);
        } else if (value.state == ResultState.noData) {
          return Center(
            child: Text(
              value.message,
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          );
        } else if (value.state == ResultState.error) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  value.message,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
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
              'Tidak ada data yang bisa ditampilkan',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          );
        }
      }))),
    );
  }
}
