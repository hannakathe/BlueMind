import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes.dart';
import '../theme/app_colors.dart';

import '../theme/theme_controller.dart';

class PreHomeScreen extends StatelessWidget {
  final List<String> images = [
    'https://images.unsplash.com/photo-1578404421628-5d0b4c8662de?q=80&w=2083&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1581242163695-19d0acfd486f?q=80&w=1974&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1441555136638-e47c0158bfc9?q=80&w=2074&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1563974514898-7aea295e12fa?q=80&w=2067&auto=format&fit=crop',
  ];

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
                child: Image.asset(
                  'assets/images/logo2.jpg', // Ruta corregida
                  height: 40, // Ajusta el tamaño
                  width: 40, // Ajusta el tamaño
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "BlueMind",
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.titlesColorDark
                      : AppColors.titlesColorLight,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: isDarkMode
                    ? AppColors.titlesColorDark
                    : AppColors.titlesColorLight,
              ),
              onPressed: themeController.toggleTheme,
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.register),
              child: Text(
                "Registrarse",
                style: TextStyle(
                    color: isDarkMode
                        ? AppColors.titlesColorDark
                        : AppColors.titlesColorLight),
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              child: Text(
                "Iniciar Sesión",
                style: TextStyle(
                    color: isDarkMode
                        ? AppColors.titlesColorDark
                        : AppColors.titlesColorLight),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      );
    });
  }
}
