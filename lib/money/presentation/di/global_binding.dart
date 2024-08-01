import 'package:get/get.dart';
import 'package:mymoney/money/data/local/local_storge.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<LocalStorage>(
          () => LocalStorage(),
      fenix: true,
    );
  }
}