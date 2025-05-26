import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';

class AppNavbarPreHome extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbarPreHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;

      return AppBar(
        backgroundColor:
            isDarkMode ? AppColors.navbarColorDark : AppColors.navbarColorLight,
        elevation: 0,
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                isDarkMode ? 'assets/logoW-invert.png' : 'assets/logoW.png',
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'BlueMind',
                style: AppTypography.blueMindtitle.copyWith(
                  color: isDarkMode
                      ? AppColors.textColorDark
                      : AppColors.textColorLight,
                ),
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
              style: AppTypography.h3Menus.copyWith(
                color: isDarkMode
                    ? AppColors.textColorDark
                    : AppColors.textColorLight,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.login),
            child: Text(
              "Iniciar Sesión",
              style: AppTypography.h3Menus.copyWith(
                color: isDarkMode
                    ? AppColors.textColorDark
                    : AppColors.textColorLight,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
