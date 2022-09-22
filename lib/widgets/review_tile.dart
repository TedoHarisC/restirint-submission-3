import 'package:flutter/material.dart';
import 'package:restirint/model/customer_review.dart';
import 'package:restirint/theme.dart';

class RevewTile extends StatelessWidget {
  final CustomerReview dataReview;

  const RevewTile({
    super.key,
    required this.dataReview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(halfMargin),
      margin: EdgeInsets.only(bottom: defaultMargin),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/placeholder_costumer.png'),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataReview.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      dataReview.date ?? '',
                      style: greyTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: semiBold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.only(left: 56),
            child: Text(
              "\" ${dataReview.review} \"",
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
