import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';

import 'money/presentation/di/global_binding.dart';
import 'money/presentation/router/router.dart';
import 'money/presentation/router/routes.dart';
import 'money/shared/core/language/app_translation.dart';
import 'money/shared/core/language/key.dart';
import 'money/shared/style/app_themes.dart';
import 'money/shared/utiles/localController.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await LocalController.init();
  runApp(const MoneyApp());
}

class MoneyApp extends StatelessWidget {
  const MoneyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalController controller =Get.put(LocalController());
    return OverlaySupport.global(
      child: GetMaterialApp(
        navigatorKey: Get.key,
        getPages: AppRouter.routes,
        initialRoute: AppRoutes.splash,
        title: StringsKeys.moneyApp.tr,
        initialBinding: GlobalBinding(),
        translations: AppTranslation(),
        locale:  controller.initLang,
        theme: AppThemes.getTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}