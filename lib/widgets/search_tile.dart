import 'package:flutter/material.dart';
import 'package:restirint/theme.dart';

class SearchTile extends StatelessWidget {
  final TextEditingController searchController;
  final String hint;
  final Function(String) onChange;

  const SearchTile({
    Key? key,
    required this.searchController,
    this.hint = '',
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (defaultMargin * 2),
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: kBlackColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              onFieldSubmitted: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
