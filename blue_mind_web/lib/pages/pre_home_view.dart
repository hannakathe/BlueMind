import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';
import '../widgets/app_navbar_prehome.dart';

class PreHomeScreen extends StatelessWidget {
  PreHomeScreen({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.backgroundColorDark
            : AppColors.backgroundColorLight,
        appBar: const AppNavbarPreHome(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenido a BlueMind',
                style: AppTypography.h1TitulosPrincipales.copyWith(
                  color: isDarkMode
                      ? AppColors.textColorDark
                      : AppColors.textColorLight,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Explora nuestro contenido educativo y descubre la biodiversidad',
                style: AppTypography.parrafos.copyWith(
                  color: isDarkMode
                      ? AppColors.textColorDark
                      : AppColors.textColorLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Get.toNamed('/home'),
                child: const Text('Entrar como invitado'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
