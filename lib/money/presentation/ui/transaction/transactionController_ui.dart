import 'package:get/get.dart';
import '../../../data/local/local_storge.dart';
import '../../../data/remote/repositories/account_repositories.dart';
import '../../../data/remote/repositories/transaction_repositories.dart';
import '../../../domain/entities/account_mode.dart';
import '../../../domain/entities/transaction_model.dart';
import '../../../shared/enums/screen_enum.dart';
import '../../../shared/enums/transaction.dart';
import '../../router/routes.dart';

class TransactionsController extends GetxController {
  final LocalStorage _storage;
  final AccountRepository _accountRepository;
  final TransactionsRepository _transactionsRepository;

  TransactionsController(this._storage,
      this._accountRepository,
      this._transactionsRepository,);

  ScreenEnums _screenEnum = ScreenEnums.loaded;

  ScreenEnums get screenEnum => _screenEnum;

  set screenEnum(ScreenEnums v) {
    _screenEnum = v;
    update();
  }

  AccountModel? account;
  List<TransactionModel> transactions = <TransactionModel>[];

  @override
  void onInit() async {
    super.onInit();
    screenEnum = ScreenEnums.loading;
    await Future.wait([
      getAccountData(),
      getTransactions(),
    ]);
    screenEnum = ScreenEnums.loaded;
    if (account == null) {
      screenEnum = ScreenEnums.error;
    }
  }

  Future<void> getAccountData() async {
    account = await _accountRepository.getAccount();
  }

  Future<void> getTransactions() async {
    transactions = await _transactionsRepository.getTransactions();
  }

  void onTapPay() => goPay(TransactionsEnums.pay);

  void onTapTopUp() => goPay(TransactionsEnums.topUp);

  void goPay(final TransactionsEnums type) async {
    final res = await Get.toNamed(
      AppRoutes.pay,
      arguments: type,
    );
    if (res == ScreenEnums.refresh) {
      onInit();
    }
  }

  void goTransaction(final String? id) async {
    if (id != null) {
      final res = await Get.toNamed(
        AppRoutes.transactionDetails,
        arguments: id,
      );
      if (res == ScreenEnums.refresh) {
        onInit();
      }
    }
  }

  void dropData() async {
    await _storage.deleteData();
    onInit();
  }
}
