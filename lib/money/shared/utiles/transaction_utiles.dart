import 'package:get/get.dart';

import '../core/language/key.dart';
import '../enums/transaction.dart';
import '../style/app_icons.dart';


bool isTopUp(final String? type) => mapTransactionsEnums[type] == TransactionsEnums.topUp;

String getTransactionIcon(final String? type) {
  switch (mapTransactionsEnums[type]) {
    case TransactionsEnums.pay:
      return AppIcons.icItemPay;
    case TransactionsEnums.topUp:
      return AppIcons.icItemTopUp;
    default:
      return '';
  }
}

String getTransactionTitle({
  required final String? type,
  required final String? merchantTitle,
}) {
  switch (mapTransactionsEnums[type]) {
    case TransactionsEnums.topUp:
      return StringsKeys.topUp.tr;
    default:
      return merchantTitle ?? '';
  }
}