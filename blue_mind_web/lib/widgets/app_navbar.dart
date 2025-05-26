import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';
import '../theme/app_typography.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(),
      drawer: const AppSidebar(),
      body: const Center(child: Text('Contenido principal aquí')),
    );
  }
}

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;
      final Color bgColor =
          isDarkMode ? AppColors.navbarColorDark : AppColors.navbarColorLight;
      final Color iconColor =
          isDarkMode ? AppColors.textColorDark : AppColors.textColorLight;
      final Color textColor =
          isDarkMode ? AppColors.textColorDark : AppColors.textColorLight;

      return LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 800;

          return AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bgColor,
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
                      color: textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            actions:
                isSmallScreen
                    ? [
                      Builder(
                        builder:
                            (context) => IconButton(
                              icon: Icon(Icons.menu, color: iconColor),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                      ),
                    ]
                    : [
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildNavLink(
                                'Inicio',
                                AppRoutes.home,
                                textColor,
                                arguments: {'auth': FirebaseAuth.instance},
                              ),
                              _buildNavLink('Blog', AppRoutes.blog, textColor),
                              _buildNavLink(
                                'Recursos\nEducativos',
                                AppRoutes.library,
                                textColor,
                              ),
                              _buildNavLink(
                                'Álbum de\nEspecies',
                                AppRoutes.album,
                                textColor,
                              ),
                              _buildNavLink(
                                'Mapa\nInteractivo',
                                AppRoutes.map,
                                textColor,
                              ),
                              const SizedBox(width: 10),
                              _buildSearchBox(isDarkMode),
                              const SizedBox(width: 10),
                              _buildProfileButton(iconColor),
                              IconButton(
                                icon: Icon(
                                  isDarkMode
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  color: iconColor,
                                ),
                                onPressed: () => themeController.toggleTheme(),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
          );
        },
      );
    });
  }

  Widget _buildNavLink(
    String text,
    String route,
    Color textColor, {
    Map<String, dynamic>? arguments,
  }) {
    return TextButton(
      onPressed: () => Get.toNamed(route, arguments: arguments),
      child: Text(
        text,
        style: AppTypography.h3Menus.copyWith(color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSearchBox(bool isDarkMode) {
    return SizedBox(
      width: 280,
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          prefixIcon: Icon(
            Icons.search,
            size: 18,
            color: isDarkMode ? Colors.white70 : Colors.black,
          ),
          filled: true,
          fillColor: isDarkMode ? Colors.grey[850] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildProfileButton(Color iconColor) {
    return IconButton(
      icon: Icon(Icons.person_outline, color: iconColor, size: 28),
      onPressed:
          () => Get.toNamed(
            AppRoutes.profile,
            arguments: {'auth': FirebaseAuth.instance},
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.isDarkMode.value;

    return Drawer(
      backgroundColor:
          isDarkMode
              ? AppColors.backgroundColorDark
              : AppColors.backgroundColorLight,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.blueGrey : Colors.blue,
            ),
            child: Text(
              'Menú',
              style: AppTypography.h2SubtitulosImportantes.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          _buildDrawerItem(context, 'Inicio', AppRoutes.home, {
            'auth': FirebaseAuth.instance,
          }),
          _buildDrawerItem(context, 'Blog', AppRoutes.blog),
          _buildDrawerItem(context, 'Recursos Educativos', AppRoutes.library),
          _buildDrawerItem(context, 'Álbum de Especies', AppRoutes.album),
          _buildDrawerItem(context, 'Mapa Interactivo', AppRoutes.map),
          _buildDrawerItem(context, 'Perfil', AppRoutes.profile, {
            'auth': FirebaseAuth.instance,
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    String route, [
    Map<String, dynamic>? arguments,
  ]) {
    return ListTile(
      title: Text(title, style: AppTypography.parrafos),
      onTap: () {
        Get.toNamed(route, arguments: arguments);
        Navigator.of(context).pop();
      },
    );
  }
}
