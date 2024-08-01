import '../../../domain/entities/account_mode.dart';





abstract class AccountRepository{

  Future<AccountModel?> getAccount();
  Future<AccountModel?> createAccount();

  }
