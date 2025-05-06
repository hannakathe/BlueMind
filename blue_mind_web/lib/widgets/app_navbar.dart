import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';
import '../theme/app_typography.dart';

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(),
      endDrawer: const AppSidebar(), // Sidebar que aparece en pantallas pequeñas
      body: Center(
        child: Text('Contenido principal aquí'),
      ),
    );
  }
}

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 800;

        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/logoW.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'BlueMind',
                style: AppTypography.blueMindtitle,
              ),
            ],
          ),
          actions: isSmallScreen
              ? [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ),
                ]
              : [
                  Row(
                    children: [
                      _buildNavLink('Inicio', AppRoutes.home, arguments: {
                        'auth': FirebaseAuth.instance,
                      }),
                      _buildNavLink('Blog', AppRoutes.blog),
                      _buildNavLink('Recursos\nEducativos', AppRoutes.library),
                      _buildNavLink('Álbum de\nEspecies', AppRoutes.album),
                      _buildNavLink('Mapa\nInteractivo', AppRoutes.map),
                      const SizedBox(width: 10),
                      _buildSearchBox(),
                      _buildProfileButton(),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
        );
      },
    );
  }

  Widget _buildNavLink(String text, String route,
      {Map<String, dynamic>? arguments}) {
    return TextButton(
      onPressed: () => Get.toNamed(route, arguments: arguments),
      child: Text(
        text,
        style: AppTypography.h3Menus,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSearchBox() {
    return SizedBox(
      width: 200,
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          prefixIcon: const Icon(Icons.search, size: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton() {
    return IconButton(
      icon: const Icon(
        Icons.person_outline,
        color: Colors.black,
        size: 28,
      ),
      onPressed: () => Get.toNamed(AppRoutes.profile, arguments: {
        'auth': FirebaseAuth.instance,
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Text(
              'Menú',
              style: AppTypography.h2SubtitulosImportantes.copyWith(color: Colors.white),
            ),
          ),
          _buildDrawerItem('Inicio', AppRoutes.home, {
            'auth': FirebaseAuth.instance,
          }),
          _buildDrawerItem('Blog', AppRoutes.blog),
          _buildDrawerItem('Recursos Educativos', AppRoutes.library),
          _buildDrawerItem('Álbum de Especies', AppRoutes.album),
          _buildDrawerItem('Mapa Interactivo', AppRoutes.map),
          _buildDrawerItem('Perfil', AppRoutes.profile, {
            'auth': FirebaseAuth.instance,
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, String route,
      [Map<String, dynamic>? arguments]) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Get.toNamed(route, arguments: arguments);
        Get.back(); // Cierra el drawer
      },
    );
  }
}
