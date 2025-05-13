import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart'; // Importación de AppHeader
import '../widgets/app_footer.dart'; // Importación de AppFooter

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 125.0;
    final verticalPadding = 50.0;

    return Scaffold(
      appBar: const AppNavbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header sin padding
            AppHeader(
              imagePath:
                  'https://images.unsplash.com/photo-1665150922942-9f48fc21005f?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              title: 'Mapa',
              subtitle: 'Explora la ubicación',
            ),

            // Contenido con padding
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 20),
                  Text(
                    'Contenido de Mapa',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),

            // Footer sin padding
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
