import 'dart:convert';
import 'dart:developer';

import 'package:mymoney/money/data/local/local_storge.dart';
import 'package:mymoney/money/domain/entities/account_mode.dart';
import '../../data/remote/repositories/account_repositories.dart';



class AccountRepositoryImpl extends AccountRepository {

  final LocalStorage _storage;

  AccountRepositoryImpl(
      this._storage,
      );

  @override
  Future<AccountModel?> getAccount() async {
    AccountModel? res;
    try {
      final String? storageRes = await _storage.getAccount();
      if (storageRes == null) {
        res = await createAccount();
      } else {
        final Map<String, dynamic> locMap = jsonDecode(storageRes);
        res = AccountModel.fromJson(locMap);
      }

    } catch (e) {
      log (e.toString() );
    }
    return res;
  }

  @override
  Future<AccountModel?> createAccount() async {
    try {
      final account = AccountModel(
        price: 0,
      );
      await _storage.setAccount(
        jsonEncode(
          account.toJson(),
        ),
      );
      return account;
    } catch (e) {
      log (e.toString() );
      return null;
    }
  }


}
