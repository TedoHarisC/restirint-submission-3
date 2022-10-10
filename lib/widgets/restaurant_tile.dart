import 'package:flutter/material.dart';
import 'package:restirint/model/local_restaurant.dart';
import 'package:restirint/pages/detail_restaurant_page.dart';
import 'package:restirint/theme.dart';

class RestaurantTile extends StatelessWidget {
  final LocalRestaurant dataRestaurant;
  final bool isFavouritePage;

  const RestaurantTile({
    Key? key,
    required this.dataRestaurant,
    required this.isFavouritePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (_, __, ___) => DetailRestaurantPage(
              dataRestaurant: dataRestaurant,
              isFavouritePage: isFavouritePage,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - (defaultMargin * 2),
        height: 112,
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: halfMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Row(
          children: [
            Hero(
              tag: dataRestaurant.pictureId,
              child: SizedBox(
                width: 142,
                height: 82,
                child: Image.network(
                  dataRestaurant.getSmallResolutionPicture(),
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
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataRestaurant.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon_location.png',
                        width: 10,
                        height: 10,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        dataRestaurant.city,
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon_star.png',
                        width: 10,
                        height: 10,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        dataRestaurant.rating.toString(),
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
