import 'package:flutter/material.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/theme.dart';
import 'package:restirint/widgets/menu_list.dart';

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
        child: Container(
          width: double.infinity,
          height: 436,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.dataRestaurant.pictureId),
            ),
          ),
        ),
      );
    }

    Widget content() {
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
                                widget.dataRestaurant.name,
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
                                        widget.dataRestaurant.city,
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
                                        widget.dataRestaurant.rating.toString(),
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
                                widget.dataRestaurant.description,
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
                                children: widget.dataRestaurant.menus.foods
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
                                children: widget.dataRestaurant.menus.drinks
                                    .map((item) {
                                  return MenuList(name: item.name);
                                }).toList(),
                              )
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
      body: Stack(
        children: [
          backgroundImage(),
          backButton(),
          content(),
        ],
      ),
    );
  }
}
