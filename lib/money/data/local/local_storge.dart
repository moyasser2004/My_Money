import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage extends GetxController {

  final GetStorage _storage = GetStorage();

  static const String account = "_account";

  static const String transaction = "_transaction";

  Future<void> _setData(final String key, final value) async =>
      await _storage.write(key, value);

  Future<T> _getData<T>(final String key) async => await _storage.read(key);

  Future<void> setAccount(final value) async =>
      await _setData(account, value);

  Future<void> setTransaction(final value) async =>
      await _setData(transaction, value);

  Future<String?> getAccount() async => await _getData(account);

  Future<String?> getTransaction() async => await _getData(transaction);

  Future<void> deleteData() async {
    Future.wait([
      _storage.remove(account),
      _storage.remove(transaction),
    ]);
  }

}
