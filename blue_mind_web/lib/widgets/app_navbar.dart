import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const CircleAvatar(backgroundColor: Colors.grey, radius: 14),
          const SizedBox(width: 8),
          const Text(
            'BlueMind',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          _buildNavLink('Inicio', AppRoutes.home),
          /*_buildNavLink('Blog', AppRoutes.blog),
          _buildNavLink('Foro', AppRoutes.foro),
          _buildNavLink('Recursos\nEducativos', AppRoutes.recursos),
          _buildNavLink('Álbum de\nEspecies', AppRoutes.album),
          _buildNavLink('Mapa\nInteractivo', AppRoutes.mapa),*/
          const SizedBox(width: 16),
          _buildSearchBox(),
          const SizedBox(width: 16),
          _buildProfileButton(),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text, String route) {
    return TextButton(
      onPressed: () => Get.toNamed(route),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSearchBox() {
    return SizedBox(
      width: 160,
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
    return TextButton.icon(
      onPressed: () => Get.toNamed(AppRoutes.profile),
      icon: const Icon(Icons.person_outline, color: Colors.black),
      label: const Text(
        'Perfil',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
