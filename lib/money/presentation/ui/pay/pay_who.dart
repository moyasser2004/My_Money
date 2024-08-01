import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_header.dart';

import '../../../shared/const/app_value.dart';
import '../../../shared/core/language/key.dart';
import '../../../shared/style/app_style.dart';
import '../../../shared/wedget/app_button.dart';
import '../../../shared/wedget/app_responsive.dart';


class PayWho extends StatelessWidget {
  final TextEditingController whomTC;
  final void Function() onTapPay;

  const PayWho({
    Key? key,
    required this.whomTC,
    required this.onTapPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PayHeader(
          header: StringsKeys.toWhom,
          child: SizedBox(
            height: 100,
            child: ResponsiveView(
              maxWidth: AppValues.secondaryWidthLimiter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 44,
                ),
                child: TextField(
                  controller: whomTC,
                  cursorColor: Get.textTheme.displayLarge?.color,
                  style: Get.textTheme.displayLarge?.copyWith(
                    fontSize: 25,
                  ),
                  decoration: inputDecorationUnderline(Get.textTheme.displayLarge?.color),
                ),
              ),
            ),
          ),
        ),
        AppMainButton(
          title: StringsKeys.next,
          margin: const EdgeInsets.only(
            bottom: 34,
          ),
          onPressed: onTapPay,
        ),
      ],
    );
  }
}