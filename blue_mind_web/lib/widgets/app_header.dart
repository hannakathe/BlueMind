// lib/widgets/app_header.dart
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final double height;

  const AppHeader({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.height = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          
          // Overlay semitransparente
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          
          // Contenido de texto
          Positioned(
            left: 20,
            bottom: 30,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}