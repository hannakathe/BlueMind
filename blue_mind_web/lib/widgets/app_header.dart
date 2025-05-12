import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:carousel_slider/carousel_controller.dart';


class AppHeader extends StatelessWidget {
  final String? imagePath;
  final List<String>? imagePaths;
  final String title;
  final String subtitle;
  final double height;

  const AppHeader({
    super.key,
    this.imagePath,
    this.imagePaths,
    required this.title,
    required this.subtitle,
    this.height = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget background;

    // Si hay imágenes en el carrusel, mostrar el carrusel
    if (imagePaths != null && imagePaths!.isNotEmpty) {
      background = CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enableInfiniteScroll: true,
          pauseAutoPlayOnTouch: true,
        ),
        items: imagePaths!.map((url) {
          return Builder(
            builder: (context) {
              return Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          );
        }).toList(),
      );
    } else {
      // Si no hay imágenes en el carrusel, mostrar una sola imagen
      background = Image.network(
        imagePath ?? '',
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Fondo del header
          Positioned.fill(child: background),
          // Overlay semitransparente
          Container(color: Colors.black.withOpacity(0.3)),
          // Contenido del texto
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
