import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LocalController extends GetxController{
  static late SharedPreferences sharedPreferences;

    static  Future<void> init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  Locale initLang= sharedPreferences.getString("lang")=="ar"?const Locale("ar"):const Locale("en");

  void changeLang(String lang)async{
    Locale locale=Locale(lang);
    await sharedPreferences.setString("lang",lang);
    Get.updateLocale(locale);
  }
}