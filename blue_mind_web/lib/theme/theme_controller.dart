import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

class ThemeController extends GetxController {
  // Variable reactiva para manejar el tema
  var isDarkMode = false.obs;

  // Método para alternar entre los modos
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }
}

// Definición del tema claro
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColorLight,
  scaffoldBackgroundColor: AppColors.backgroundColorLight,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.textColorLight),
  ),
);

// Definición del tema oscuro
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColorDark,
  scaffoldBackgroundColor: AppColors.backgroundColorDark,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.textColorDark),
  ),
);
