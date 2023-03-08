import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/services/api_services.dart';

class HomeController extends GetxController {
  var isdark = false.obs;
  var currentWeather;

  chnageTheme() {
    isdark.value = !isdark.value;
    Get.changeThemeMode(isdark.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onInit() {
    currentWeather = getCurrentWeather();
    super.onInit();
  }
}
