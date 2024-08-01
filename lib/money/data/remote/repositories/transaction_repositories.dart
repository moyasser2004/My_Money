import '../../../domain/entities/account_mode.dart';
import '../../../domain/entities/transaction_model.dart';

abstract class TransactionsRepository {
  Future<List<TransactionModel>> getTransactions();

  Future<TransactionModel?> getTransactionById(final String id);

  Future<bool> pay({
    required final TransactionModel v,
    required final AccountModel a,
  });

  Future<bool> setRepeatingPayment({
    required final TransactionModel v,
    required final TransactionModel p,
    required final AccountModel a,
  });

  Future<bool> splitBill({
    required final TransactionModel v,
    required final TransactionModel p,
    required final AccountModel a,
  });
}
