import 'package:flutter/material.dart';
import 'package:restirint/theme.dart';
import 'package:shimmer/shimmer.dart';

class ListSkeletonItem extends StatelessWidget {
  const ListSkeletonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (defaultMargin * 2),
      height: 112,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: kBackgroundColor,
            highlightColor: kGreyColor,
            child: Container(
              width: 142,
              height: 82,
              color: kBackgroundColor,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: kBackgroundColor,
                highlightColor: kGreyColor,
                child: Container(
                  width: MediaQuery.of(context).size.width -
                      (142 + (2 * defaultMargin) + 36),
                  height: 14,
                  color: kBackgroundColor,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: kBackgroundColor,
                    highlightColor: kGreyColor,
                    child: Container(
                      width: 78,
                      height: 14,
                      color: kBackgroundColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
