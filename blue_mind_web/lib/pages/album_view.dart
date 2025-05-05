// lib/views/blog_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart'; // Importa el nuevo header
import 'species_format.dart';

class AlbumView extends StatelessWidget {
  const AlbumView({super.key});

  void _showPostDetails(BuildContext context, String title, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpeciesFormat(title: title, imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 125.0;
    final verticalPadding = 110.0;

    final posts = List.generate(6, (index) {
      return {
        'title': 'Post #$index',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'image': 'assets/images/sample${index % 3 + 1}.jpg',
      };
    });

    return Scaffold(
      appBar: const AppNavbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          children: [
            const AppHeader(
              imagePath: 'assets/images/header.jpg',
              title: 'Bienvenido al Album de Especies',
              subtitle:
                  'Descubre nuestros últimos artículos y novedades del mundo digital.',
              height: 300, // Cambia esto si deseas más alto o más bajo
            ),
            const SizedBox(height: 30),
            StaggeredGrid.count(
              crossAxisCount: 10,
              mainAxisSpacing: 32,
              crossAxisSpacing: 30,
              children:
                  posts.map((post) {
                    return _buildTile(context, post, 2, 2);
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    Map<String, String> post,
    int crossAxisCellCount,
    double mainAxisCellCount,
  ) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: GestureDetector(
        onTap: () => _showPostDetails(context, post['title']!, post['image']!),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  post['image']!,
                  height: 200, // imagen más grande
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
