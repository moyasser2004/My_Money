import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_controller.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_enum.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_top_up.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_who.dart';

import '../../../shared/core/language/key.dart';
import '../../../shared/enums/screen_enum.dart';
import '../../../shared/wedget/app_button.dart';
import '../../../shared/wedget/app_error.dart';
import '../../../shared/wedget/app_progresIndector.dart';

class PayScreen extends GetView<PayController> {
  const PayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayController>(
      autoRemove: false,
      builder: (_) {
        if (controller.screenEnum == ScreenEnums.error) {
          return const ErrorScreen(
            hideBack: false,
          );
        } else if (controller.screenEnum == ScreenEnums.loading) {
          return const AppProgress();
        } else {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
              backgroundColor: Get.theme.primaryColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  StringsKeys.moneyApp.tr,
                ),
                actions: [
                  AppCancelButton(
                    onTap: controller.onWillPop,
                    color: Get.theme.appBarTheme.titleTextStyle?.color,
                  ),
                ],
              ),
              body: SafeArea(
                child: Builder(
                  builder: (_) {
                    if (controller.payEnum == PayEnums.payTopUp) {
                      return PayTopUp(
                        price: controller.price,
                        onTapNext: controller.onTapNext,
                      );
                    } else if (controller.payEnum == PayEnums.payWho) {
                      return PayWho(
                        whomTC: controller.whomTC,
                        onTapPay: controller.onTapPay,
                      );
                    } else {
                      return const ErrorScreen();
                    }
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}