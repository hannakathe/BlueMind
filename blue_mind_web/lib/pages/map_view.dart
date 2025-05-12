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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: AppHeader(
              imagePath: 'https://images.unsplash.com/photo-1665150922942-9f48fc21005f?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              title: 'Mapa',
              subtitle: 'Explora la ubicación',
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Contenido de Mapa',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Spacer(), // Para empujar el footer hacia abajo si es necesario
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: const AppFooter(), // Llamamos el footer aquí
          ),
        ],
      ),
    );
  }
}
