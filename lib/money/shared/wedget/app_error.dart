import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/language/key.dart';
import '../utiles/utiles.dart';
import 'app_button.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final bool hideBack;

  const ErrorScreen({
    Key? key,
    this.title = StringsKeys.somethingWentWrong,
    this.hideBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isApple() ? CupertinoIcons.exclamationmark_circle : Icons.error_outline,
                      size: 50,
                      color: Get.theme.textTheme.titleMedium?.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        title.tr,
                        textAlign: TextAlign.center,
                        style: Get.theme.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Offstage(
                offstage: hideBack,
                child: const AppBackButton(),
              ),
            )
          ],
        ),
      ),
    );
  }
}