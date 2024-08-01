import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/money/presentation/ui/splash/splashControler_ui.dart';

import '../../../shared/core/language/key.dart';



class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Center(
          child: Text(
            StringsKeys.moneyApp.tr,
            textAlign: TextAlign.center,
            style: Get.textTheme.titleLarge?.copyWith(fontSize: 25),
          ),
        ),
      ),
    );
  }
}

