import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/money/presentation/ui/transactionDetels/tran_detailsController.dart';
import 'package:mymoney/money/presentation/ui/transactionDetels/transaction_act.dart';
import 'package:mymoney/money/presentation/ui/transactionDetels/transaction_header.dart';

import '../../../shared/core/language/key.dart';
import '../../../shared/enums/screen_enum.dart';
import '../../../shared/style/app_color.dart';
import '../../../shared/style/app_icons.dart';
import '../../../shared/utiles/transaction_utiles.dart';
import '../../../shared/wedget/app_button.dart';
import '../../../shared/wedget/app_error.dart';
import '../../../shared/wedget/app_progresIndector.dart';
import '../../../shared/wedget/app_responsive.dart';


class TransactionDetailsScreen extends GetView<TransactionDetailsController> {
  const TransactionDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionDetailsController>(
      autoRemove: false,
      builder: (_) {
        if (controller.screenEnum == ScreenEnums.error) {
          return const ErrorScreen();
        } else if (controller.screenEnum == ScreenEnums.loading) {
          return const AppProgress();
        } else {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
              appBar: AppBar(
                leading: AppBackButton(
                  onTap: controller.onWillPop,
                  color: Get.theme.appBarTheme.titleTextStyle?.color,
                ),
                title: Text(
                  StringsKeys.moneyApp.tr,
                ),
              ),
              body: SingleChildScrollView(
                child: ResponsiveView(
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TransactionHeader(
                          transaction: controller.transaction,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 31,
                          ),
                          child: _buildHeader(StringsKeys.shareTheCost),
                        ),
                        TransactionActionItem(
                          icon: AppIcons.icAddReceipt,
                          title: StringsKeys.addReceipt,
                          function: controller.thirdSplit,
                          margin: const EdgeInsets.only(
                            bottom: 57,
                          ),
                        ),
                        _buildHeader(StringsKeys.shareTheCost),
                        TransactionActionItem(
                          offstage: isTopUp(controller.transaction?.type),
                          icon: AppIcons.icSplitBill,
                          title: StringsKeys.splitThisBill,
                          function: controller.splitThisBill,
                          margin: const EdgeInsets.only(
                            bottom: 31,
                          ),
                        ),
                        _buildHeader(StringsKeys.subscription),
                        TransactionActionItem(
                          offstage: isTopUp(controller.transaction?.type),
                          title: StringsKeys.repeatingPayment,
                          function: controller.repeatingPayment,
                          margin: const EdgeInsets.only(
                            bottom: 57,
                          ),
                        ),
                        TransactionActionItem(
                          title: StringsKeys.somethingWrongGetHelp,
                          color: AppColors.red,
                          function: controller.getHelp,
                        ),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildHeader(final String header) {
    return Offstage(
      offstage: isTopUp(controller.transaction?.type),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 17,
          bottom: 2,
        ),
        child: Text(
          header.tr.toUpperCase(),
          style: Get.textTheme.titleSmall,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 48,
          bottom: 12,
        ),
        child: Text(
          _getFooterText(),
          textAlign: TextAlign.center,
          style: Get.textTheme.labelSmall,
        ),
      ),
    );
  }

  String _getFooterText() {
    String res = '';
    if ((controller.transaction?.transactionId ?? '').isNotEmpty) {
      res = '$res${StringsKeys.transactionID.tr} #${controller.transaction?.transactionId}\n';
    }
    if ((controller.transaction?.merchantTitle ?? '').isNotEmpty) {
      res = '$res${controller.transaction?.merchantTitle}';
    }
    if ((controller.transaction?.merchantId ?? '').isNotEmpty && (controller.transaction?.merchantTitle ?? '').isNotEmpty) {
      res = '$res - ';
    }
    if ((controller.transaction?.merchantId ?? '').isNotEmpty) {
      res = '$res${StringsKeys.merchantID.tr} #${controller.transaction?.merchantId}';
    }
    return res;
  }
}
