import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restirint/model/customer_review.dart';
import 'package:restirint/providers/restaurant_provider.dart';
import 'package:restirint/theme.dart';
import 'package:restirint/widgets/general_button.dart';

class FormTambahReview extends StatefulWidget {
  final String idRestaurant;
  const FormTambahReview({
    super.key,
    required this.idRestaurant,
  });

  @override
  State<FormTambahReview> createState() => _FormTambahReviewState();
}

class _FormTambahReviewState extends State<FormTambahReview> {
  final TextEditingController namaController = TextEditingController(text: '');
  final TextEditingController reviewController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    PreferredSize header() {
      return PreferredSize(
        // ignore: sort_child_properties_last
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
        preferredSize: const Size.fromHeight(70),
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
            controller: namaController,
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
            controller: reviewController,
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
        CustomerReview customerReview = CustomerReview(
          id: widget.idRestaurant,
          name: namaController.text,
          review: reviewController.text,
        );

        return GestureDetector(
          onTap: () {
            Provider.of<RestaurantsProvider>(context, listen: false)
                .postReview(customerReview)
                .then((value) {
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
