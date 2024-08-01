import 'dart:convert';
import 'package:get/get.dart';
import 'package:mymoney/money/data/local/local_storge.dart';
import 'package:mymoney/money/domain/entities/account_mode.dart';
import 'package:mymoney/money/domain/entities/transaction_model.dart';
import '../../data/remote/repositories/transaction_repositories.dart';
import 'dart:developer';


class TransactionsRepositoryImpl extends TransactionsRepository {

  final LocalStorage _storage;

  TransactionsRepositoryImpl(
      this._storage,
      );

  @override
  Future<List<TransactionModel>> getTransactions() async {
    List<TransactionModel> res = <TransactionModel>[];
    try {
      final String? storageRes = await _storage.getTransaction();
      if (storageRes != null) {
        res = (jsonDecode(storageRes) as List).map((e) => TransactionModel.fromJson(e)).toList();
        res.sort((i, j) => j.createdAt!.compareTo(i.createdAt!));
      }

    } catch (e) {
      log (e.toString() );
    }
    return res;
  }


  @override
  Future<TransactionModel?> getTransactionById(final String id) async {
    try {
      final List<TransactionModel> storageRes = await getTransactions();
      final TransactionModel? res = storageRes.firstWhereOrNull((e) => e.transactionId == id);

      return res;
    } catch (e) {
      log (e.toString() );
      return null;
    }
  }

  @override
  Future<bool> pay({
    required final TransactionModel v,
    required final AccountModel a,
  }) async {
    try {
      final List<TransactionModel> storageRes = await getTransactions();
      storageRes.add(v);
      List<Map<String, dynamic>> res = <Map<String, dynamic>>[];
      for (int i = 0; i < storageRes.length; i++) {
        res.add(storageRes[i].toJson());
      }
      await Future.wait([
        _storage.setTransaction(jsonEncode(res)),
        _storage.setAccount(jsonEncode(a.toJson())),
      ]);

      return true;
    } catch (e) {
      log (e.toString() );
      return false;
    }
  }

  @override
  Future<bool> setRepeatingPayment({
    required final TransactionModel v,
    required final TransactionModel p,
    required final AccountModel a,
  }) async {
    try {
      final List<TransactionModel> storageRes = await getTransactions();
      storageRes.removeWhere((e) => e.transactionId == v.transactionId);
      storageRes.add(v);
      storageRes.add(p);
      List<Map<String, dynamic>> res = <Map<String, dynamic>>[];
      for (int i = 0; i < storageRes.length; i++) {
        res.add(storageRes[i].toJson());
      }
      await Future.wait([
        _storage.setTransaction(jsonEncode(res)),
        _storage.setAccount(jsonEncode(a.toJson())),
      ]);

      return true;
    } catch (e) {
      log (e.toString() );
      return false;
    }
  }

  @override
  Future<bool> splitBill({
    required final TransactionModel v,
    required final TransactionModel p,
    required final AccountModel a,
  }) async {
    try {
      final List<TransactionModel> storageRes = await getTransactions();
      storageRes.removeWhere((e) => e.transactionId == v.transactionId);
      storageRes.add(v);
      storageRes.add(p);
      List<Map<String, dynamic>> res = <Map<String, dynamic>>[];
      for (int i = 0; i < storageRes.length; i++) {
        res.add(storageRes[i].toJson());
      }
      await Future.wait([
        _storage.setTransaction(jsonEncode(res)),
        _storage.setAccount(jsonEncode(a.toJson())),
      ]);

      return true;
    } catch (e) {
      log (e.toString() );
      return false;
    }
  }
}
