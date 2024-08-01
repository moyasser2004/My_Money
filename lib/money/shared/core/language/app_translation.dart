import 'package:get/get.dart';
import 'package:mymoney/money/shared/const/app_value.dart';
import 'ar.dart';
import 'en.dart';



 class AppTranslation extends Translations{
  @override

  Map<String, Map<String, String>> get keys => {
    AppValues.langCodeEN:en,
    AppValues.langCodeAR:ar,
  };


 }