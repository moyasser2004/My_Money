import 'package:get/get.dart';

import '../../../shared/utiles/utiles.dart';
import '../../router/routes.dart';



class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    start();
  }

  void start() async {
    await delayedFunc(milliseconds: 1400);
    goTransactions();
  }

  void goTransactions() => Get.offAllNamed(AppRoutes.transactions);
}