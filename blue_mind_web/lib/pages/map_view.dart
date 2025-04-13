import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(),
      body: const Center(child: Text('Contenido de Mapa')),
    );
  }
}
