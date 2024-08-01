import 'package:get/get.dart';

import '../ui/splash/splashControler_ui.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}