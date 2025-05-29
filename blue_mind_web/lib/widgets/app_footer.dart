import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../theme/app_typography.dart'; // Importamos la tipografía

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;
      final backgroundColor = isDarkMode 
          ? AppColors.footerBackgroundDark 
          : AppColors.footerBackgroundLight;
      final textColor = isDarkMode 
          ? AppColors.textColorDark 
          : AppColors.textColorLight;
      final dividerColor = isDarkMode 
          ? Colors.grey[700] 
          : Colors.grey[300];

      return Container(
        width: double.infinity,
        color: backgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: isSmallScreen ? 20 : 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Explora, aprende y actúa. Porque el futuro del planeta está en nuestras manos',
                style: AppTypography.h1TitulosPrincipales.copyWith(
                  color: textColor,
                ),
              ),
            ),

            // Menús
            isSmallScreen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _menuColumn(
                        'Menú',
                        {
                          'Inicio': AppRoutes.home,
                          'Blog': AppRoutes.blog,
                          'Recursos Educativos': AppRoutes.library,
                          'Álbum de Especies': AppRoutes.album,
                        },
                        isDarkMode: isDarkMode,
                        isAuthRequired: true,
                      ),
                      const SizedBox(height: 20),
                      _menuColumn(
                        'Perfil',
                        {
                          'Perfil': AppRoutes.profile,
                        },
                        isDarkMode: isDarkMode,
                        isAuthRequired: true,
                      ),
                      const SizedBox(height: 20),
                      _menuColumn(
                        'Síguenos',
                        {
                          'Facebook': '',
                          'Twitter': '',
                          'Instagram': '',
                          'LinkedIn': '',
                        },
                        isDarkMode: isDarkMode,
                        isSocial: true,
                      ),
                      const SizedBox(height: 20),
                      _menuColumn(
                        'Contáctanos',
                        {
                          '📧 Hello@BlueMind.com': '',
                        },
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _menuColumn(
                        'Menú',
                        {
                          'Inicio': AppRoutes.home,
                          'Blog': AppRoutes.blog,
                          'Recursos Educativos': AppRoutes.library,
                          'Álbum de Especies': AppRoutes.album,                        },
                        isDarkMode: isDarkMode,
                        isAuthRequired: true,
                      ),
                      _menuColumn(
                        'Perfil',
                        {
                          'Perfil': AppRoutes.profile,
                        },
                        isDarkMode: isDarkMode,
                        isAuthRequired: true,
                      ),
                      _menuColumn(
                        'Síguenos',
                        {
                          'Facebook': '',
                          'Twitter': '',
                          'Instagram': '',
                          'LinkedIn': '',
                        },
                        isDarkMode: isDarkMode,
                        isSocial: true,
                      ),
                      _menuColumn(
                        'Contáctanos',
                        {
                          'Hello@BlueMind.com': '',
                        },
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),

            const SizedBox(height: 30),
            Divider(color: dividerColor),
            const SizedBox(height: 10),

            // Footer inferior responsivo
            isSmallScreen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ALLRIGHT RESERVED – BLUEMIND',
                        style: AppTypography.textoSecundario.copyWith(
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'POLÍTICA DE PRIVACIDAD    |    CONDICIONES DE USO',
                        style: AppTypography.textoSecundario.copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ALLRIGHT RESERVED – BLUEMIND',
                        style: AppTypography.textoSecundario.copyWith(
                          color: textColor,
                        ),
                      ),
                      Text(
                        'POLÍTICA DE PRIVACIDAD    |    CONDICIONES DE USO',
                        style: AppTypography.textoSecundario.copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      );
    });
  }

  Widget _menuColumn(
    String title,
    Map<String, String> items, {
    bool isSocial = false,
    bool isAuthRequired = false,
    required bool isDarkMode,
  }) {
    final textColor = isDarkMode 
        ? AppColors.textColorDark 
        : AppColors.textColorLight;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                style: AppTypography.h2SubtitulosImportantes.copyWith(
                  color: textColor,
                ),
              ),
            const SizedBox(height: 10),
            for (var entry in items.entries)
              HoverLink(
                text: entry.key,
                route: entry.value,
                isAuthRequired: isAuthRequired,
                isDarkMode: isDarkMode,
              ),
          ],
        ),
      ),
    );
  }
}

class HoverLink extends StatefulWidget {
  final String text;
  final String route;
  final bool isAuthRequired;
  final bool isDarkMode;

  const HoverLink({
    super.key,
    required this.text,
    required this.route,
    required this.isAuthRequired,
    required this.isDarkMode,
  });

  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.isDarkMode 
        ? AppColors.textColorDark 
        : AppColors.textColorLight;
    final hoverColor = widget.isDarkMode 
        ? Colors.blue[300] 
        : Colors.blue[700];

    final style = AppTypography.parrafos.copyWith(
      color: isHovered ? hoverColor : defaultColor,
      fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
      decoration: isHovered ? TextDecoration.underline : TextDecoration.none,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.route.isNotEmpty) {
            if (widget.isAuthRequired) {
              final auth = FirebaseAuth.instance;
              Get.toNamed(widget.route, arguments: {'auth': auth});
            } else {
              Get.toNamed(widget.route);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              Text(
                '› ',
                style: AppTypography.parrafos.copyWith(
                  fontWeight: FontWeight.bold,
                  color: defaultColor,
                ),
              ),
              Text(widget.text, style: style),
            ],
          ),
        ),
      ),
    );
  }
}