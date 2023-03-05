import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isdark = false.obs;

  chnageTheme() {
    isdark.value = !isdark.value;
    Get.changeThemeMode(isdark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
