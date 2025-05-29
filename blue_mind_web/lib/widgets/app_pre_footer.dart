import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../theme/app_typography.dart';

class AppPreFooter extends StatelessWidget {
  const AppPreFooter({super.key});

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
      final textColor =
          isDarkMode ? AppColors.textColorDark : AppColors.textColorLight;
      final dividerColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: _menuColumn(
                    'Acceso',
                    {
                      'Iniciar Sesión': AppRoutes.login,
                      'Registrarse': AppRoutes.register,
                    },
                    isDarkMode: isDarkMode,
                    isAuthRequired: false,
                  ),
                ),
                Expanded(
                  child: _menuColumn(
                    'Síguenos',
                    {
                      'Facebook': 'https://www.facebook.com/?locale=es_LA',
                      'Twitter': 'https://x.com/?lang=es',
                      'Instagram': 'https://www.instagram.com/',
                      'LinkedIn': 'https://www.linkedin.com/home',
                    },
                    isDarkMode: isDarkMode,
                    isExternal: true,
                  ),
                ),
                Expanded(
                  child: _menuColumn(
                    'Contáctanos',
                    {
                      'Hello@BlueMind.com': '',
                    },
                    isDarkMode: isDarkMode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Divider(color: dividerColor),
            const SizedBox(height: 10),
            isSmallScreen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ALL RIGHTS RESERVED – BLUEMIND',
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
                        'ALL RIGHTS RESERVED – BLUEMIND',
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
    required bool isDarkMode,
    bool isAuthRequired = false,
    bool isExternal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: AppTypography.h2SubtitulosImportantes.copyWith(
                color: isDarkMode
                    ? AppColors.textColorDark
                    : AppColors.textColorLight,
              ),
            ),
          const SizedBox(height: 10),
          for (var entry in items.entries)
            HoverLink(
              text: entry.key,
              route: entry.value,
              isAuthRequired: isAuthRequired,
              isDarkMode: isDarkMode,
              isExternal: isExternal,
            ),
        ],
      ),
    );
  }
}

class HoverLink extends StatefulWidget {
  final String text;
  final String route;
  final bool isAuthRequired;
  final bool isDarkMode;
  final bool isExternal;

  const HoverLink({
    super.key,
    required this.text,
    required this.route,
    required this.isAuthRequired,
    required this.isDarkMode,
    this.isExternal = false,
  });

  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor =
        widget.isDarkMode ? AppColors.textColorDark : AppColors.textColorLight;
    final hoverColor =
        widget.isDarkMode ? Colors.blue[300] : Colors.blue[700];

    final style = AppTypography.parrafos.copyWith(
      color: isHovered ? hoverColor : defaultColor,
      fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
      decoration: isHovered ? TextDecoration.underline : TextDecoration.none,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () async {
          if (widget.route.isNotEmpty) {
            if (widget.isExternal) {
              final Uri url = Uri.parse(widget.route);
              if (await canLaunchUrl(url)) {
                // Usa LaunchMode.externalApplication para abrir en navegador externo
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                // Opcional: mostrar mensaje si no se puede abrir la URL
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se pudo abrir el enlace')),
                );
              }
            } else {
              if (widget.isAuthRequired) {
                final auth = FirebaseAuth.instance;
                Get.toNamed(widget.route, arguments: {'auth': auth});
              } else {
                Get.toNamed(widget.route);
              }
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
