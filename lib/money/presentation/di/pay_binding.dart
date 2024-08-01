import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../data/local/local_storge.dart';
import '../../data/remote/repositories/account_repositories.dart';
import '../../data/remote/repositories/transaction_repositories.dart';
import '../../domain/repositories/account_repositories_implemntion.dart';
import '../../domain/repositories/transaction_repositories_implemntion.dart';
import '../ui/pay/pay_controller.dart';


class PayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountRepository>(
          () => AccountRepositoryImpl(

        Get.find<LocalStorage>(),
      ),
      fenix: true,
    );
    Get.lazyPut<TransactionsRepository>(
          () => TransactionsRepositoryImpl(

        Get.find<LocalStorage>(),
      ),
      fenix: true,
    );
    Get.put(
      PayController(
        Get.find<AccountRepository>(),
        Get.find<TransactionsRepository>(),
      ),
    );
  }
}
