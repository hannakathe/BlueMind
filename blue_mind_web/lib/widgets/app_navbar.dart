import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';
import '../theme/app_typography.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: SingleChildScrollView( // Permite hacer scroll horizontal
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const CircleAvatar(backgroundColor: Colors.grey, radius: 14),
            const SizedBox(width: 8),
            Text(
              'BlueMind',
              style: AppTypography.blueMindtitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 620),
                _buildNavLink('Inicio', AppRoutes.home),
                const SizedBox(width: 20),
                _buildNavLink('Blog', AppRoutes.blog),
                const SizedBox(width: 20),
                _buildNavLink('Foro', AppRoutes.forum),
                const SizedBox(width: 20),
                _buildNavLink('Recursos\nEducativos', AppRoutes.library),
                const SizedBox(width: 20),
                _buildNavLink('Álbum de\nEspecies', AppRoutes.album),
                const SizedBox(width: 20),
                _buildNavLink('Mapa\nInteractivo', AppRoutes.map),
                const SizedBox(width: 20),
                _buildSearchBox(),
                const SizedBox(width: 20),
                _buildProfileButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String text, String route) {
    return TextButton(
      onPressed: () => Get.toNamed(route),
      child: Text(
        text,
        style: AppTypography.h3Menus,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSearchBox() {
    return SizedBox(
      width: 300,
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
        size: 32, // Tamaño aumentado del ícono
      ),
      onPressed: () => Get.toNamed(AppRoutes.profile),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}