import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppIcons {
  // Definición de la constante de color
  static const Color iconColor = Colors.blue;  // Puedes cambiar 'Colors.blue' por cualquier color que desees

  // Íconos con su color asignado
  static const IconData home = Icons.home;
  static const IconData blog = Icons.article;
  static const IconData forum = Icons.forum;
  static const IconData resources = Icons.menu_book;
  static const IconData album = Icons.photo_album;
  static const IconData map = Icons.map;
  static const IconData search = Icons.search;
  static const IconData profile = Icons.person_outline;

  // Método para aplicar color a los íconos
  static Icon getIcon(IconData icon) {
    return Icon(icon, color: AppColors.textColorLight);
  }
}
