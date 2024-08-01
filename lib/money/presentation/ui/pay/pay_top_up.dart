import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_header.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_price_widget.dart';

import '../../../shared/core/language/key.dart';
import '../../../shared/wedget/app_button.dart';
import 'numeric_keyboard.dart';


class PayTopUp extends StatelessWidget {
  final RxString price;
  final void Function() onTapNext;

  const PayTopUp({
    Key? key,
    required this.price,
    required this.onTapNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PayHeader(
          header: StringsKeys.howMuch,
          child: PayPriceWidget(
            price: price,
          ),
        ),
        NumericKeyboard(
          value: price,
        ),
        AppMainButton(
          title: StringsKeys.next,
          margin: const EdgeInsets.only(
            bottom: 34,
          ),
          onPressed: onTapNext,
        ),
      ],
    );
  }
}