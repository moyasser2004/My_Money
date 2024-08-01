import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/money/shared/style/app_color.dart';

import '../../../shared/utiles/utiles.dart';



class PriceWidget extends StatelessWidget {

  final double? price;

  const PriceWidget({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      right: 2,
      left: 2,
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'LE ',
                style: Get.textTheme.displayLarge?.copyWith(
                  fontSize: 22,
                  color: AppColors.black
                ),
              ),
              TextSpan(
                text: priceParser(price).split('.')[0],
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                )
              ),
              TextSpan(
                text: '.${priceParser(price).split('.')[1]}',
                style: Get.textTheme.displayLarge?.copyWith(
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}