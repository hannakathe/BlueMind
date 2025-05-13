import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';

class PreHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;
      return Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.backgroundColorDark
            : AppColors.backgroundColorLight,
        appBar: AppBar(
          backgroundColor:
              isDarkMode ? AppColors.primaryColorDark : AppColors.borderLight,
          elevation: 0,
          title: Row(
            children: [
              ClipOval(
                child: Image(image: AssetImage('assets/logoW-invert.png',
                ),
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'BlueMind',
                  style: AppTypography.blueMindtitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: isDarkMode
                    ? AppColors.textColorDark
                    : AppColors.textColorLight,
              ),
              onPressed: themeController.toggleTheme,
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.register),
              child: Text(
                "Registrarse",
                style: TextStyle(
                    color: isDarkMode
                        ? AppColors.textColorDark
                        : AppColors.textColorLight),
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              child: Text(
                "Iniciar Sesión",
                style: TextStyle(
                    color: isDarkMode
                        ? AppColors.textColorDark
                        : AppColors.textColorLight),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      );
    });
  }
}
