// lib/views/blog_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart'; // Importa el nuevo header

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  void _showPostDetails(BuildContext context, String title, String description, String imagePath) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath),
            const SizedBox(height: 12),
            Text(description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
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
        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
              imagePath: 'assets/images/libreria.jpg',
              title: 'Bienvenido a la libreria de recursos educativos',
              subtitle: 'Descubre nuestros últimos artículos y novedades del mundo digital.',
              height: 300, // Cambia esto si deseas más alto o más bajo
            ),
            const SizedBox(height: 50),
            StaggeredGrid.count(
              crossAxisCount: 6,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: posts.map((post) {
                return _buildTile(
                  context,
                  post,
                  3,
                  4,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, Map<String, String> post, int crossAxisCellCount, double mainAxisCellCount) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: GestureDetector(
        onTap: () => _showPostDetails(context, post['title']!, post['description']!, post['image']!),
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
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                post['description']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 6),
              const Text(
                '14 March 2018',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
