import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/money/presentation/ui/transaction/transactionController_ui.dart';
import 'package:mymoney/money/shared/style/app_color.dart';

import '../../../shared/core/language/key.dart';
import '../../../shared/enums/screen_enum.dart';
import '../../../shared/utiles/date_utiles.dart';
import '../../../shared/utiles/localController.dart';
import '../../../shared/utiles/utiles.dart';
import '../../../shared/wedget/app_button.dart';
import '../../../shared/wedget/app_error.dart';
import '../../../shared/wedget/app_progresIndector.dart';
import '../../../shared/wedget/app_responsive.dart';
import '../wedget/card_wedget.dart';
import '../wedget/price_wedget.dart';
import '../wedget/tran_item.dart';


class TransactionsScreen extends GetView<TransactionsController> {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalController c=Get.find();
    return GetBuilder<TransactionsController>(
      autoRemove: false,
      builder: (_) {
        if (controller.screenEnum == ScreenEnums.error) {
          return const ErrorScreen();
        } else if (controller.screenEnum == ScreenEnums.loading) {
          return const AppProgress();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                StringsKeys.moneyApp.tr,
              ),
              actions: [
                SmallIconButton(
                  onPressed: controller.dropData,
                  icon: isApple() ? CupertinoIcons.delete : Icons.delete_outline,
                  color: Get.theme.appBarTheme.titleTextStyle?.color,
                  message: StringsKeys.clear,
                ),
                SmallIconButton(
                  onPressed: (){
                    if(LocalController.sharedPreferences.getString("lang")=="ar"){
                      c.changeLang("en");
                    }else{
                      c.changeLang("ar");
                    }
                  },
                  icon: isApple() ? CupertinoIcons.repeat_1 : Icons.change_circle,
                  color: Get.theme.appBarTheme.titleTextStyle?.color,
                  message: StringsKeys.changeLang,
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(220),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildBackground(),
                    PriceWidget(
                      price: controller.account?.price,
                    ),
                    CardWidget(
                      onTapPay: controller.onTapPay,
                      onTapTopUp: controller.onTapTopUp,
                    ),
                  ],
                ),
              ),
            ),
            body: controller.transactions.isEmpty ? const ErrorScreen(
              title: StringsKeys.youHaveNoTransactions,
            ) : ResponsiveView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.transactions.length,
                      itemBuilder: (_, i) {
                        return _buildTransactionItem(i);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height:200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 140,
            width: double.infinity,
            child: ColoredBox(
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ColoredBox(
              color: Get.theme.scaffoldBackgroundColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 5
      ),
      child: Text(
        StringsKeys.recentActivity.tr,
        style: Get.textTheme.labelLarge,
      ),
    );
  }

  Widget _buildTransactionItem(final int i) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Offstage(
          offstage: _checkDateSeparator(i),
          child: _buildDateSeparator(i),
        ),
        TransactionItem(
          item: controller.transactions[i],
          onTap: controller.goTransaction,
        ),
        _bottomSeparator(
          i: i,
          j: controller.transactions.length,
        ),
      ],
    );
  }

  Widget _buildDateSeparator(final int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      child: Text(
        getDateYT(controller.transactions[i].createdAt).toString(),
        style: Get.textTheme.labelSmall,
      ),
    );
  }

  bool _checkDateSeparator(final int i) {
    bool hideDate = false;
    if (i != controller.transactions.length && i != 0 && controller.transactions.isNotEmpty) {
      if (isTheSameDay(
        firstDate: controller.transactions[i - 1].createdAt,
        secondDate: controller.transactions[i].createdAt,
      )) {
        hideDate = true;
      }
    }
    return hideDate;
  }

  Widget _bottomSeparator({
    required final int i,
    required final int j,
  }) {
    return Offstage(
      offstage: i + 1 != j,
      child: const SafeArea(
        child: SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
