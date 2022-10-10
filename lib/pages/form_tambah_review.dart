import 'package:flutter/material.dart';
import 'package:restirint/model/customer_review.dart';
import 'package:restirint/providers/restaurant_provider.dart';
import 'package:restirint/theme.dart';
import 'package:restirint/widgets/general_button.dart';

class FormTambahReview extends StatelessWidget {
  final String idRestaurant;
  final RestaurantsProvider provider;

  FormTambahReview({
    super.key,
    required this.idRestaurant,
    required this.provider,
  });

  final TextEditingController _namaController = TextEditingController(text: '');

  final TextEditingController _reviewController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Row(
            children: [
              Text(
                'Tambah Review Baru',
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      Widget namaInput() {
        return Container(
          margin: const EdgeInsets.only(top: 48, left: 6, right: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: _namaController,
            decoration: InputDecoration.collapsed(
              hintText: 'Nama Anda',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        );
      }

      Widget reviewInput() {
        return Container(
          margin: const EdgeInsets.only(top: 48, left: 6, right: 6, bottom: 30),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: _reviewController,
            decoration: InputDecoration.collapsed(
              hintText: 'Tuliskan Review',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        );
      }

      Widget submitButton() {
        return GestureDetector(
          onTap: () {
            CustomerReview customerReview = CustomerReview(
              id: idRestaurant,
              name: _namaController.text,
              review: _reviewController.text,
            );

            provider.postReview(customerReview).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kGreenColor,
                  content: const Text('Review anda sukses terkirim'),
                ),
              );

              Navigator.pop(context);
            });
          },
          child: GeneralButton(
            text: 'Tambah Review',
            backgroundColor: kPrimaryColor,
            textColor: kWhiteColor,
            width: double.infinity,
            borderRadius: 6,
            height: 48,
            fontSize: 16,
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(left: 10, bottom: 20, right: 10),
        child: Column(
          children: [
            namaInput(),
            reviewInput(),
            submitButton(),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: content(),
      ),
    );
  }
}
