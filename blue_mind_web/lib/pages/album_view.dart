// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import 'species_format_view.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../models/species_model.dart'; // Ajusta la ruta según tu estructura

class AlbumView extends StatefulWidget {
  const AlbumView({super.key});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  List<dynamic> speciesList = [];
  bool isLoading = true;

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    fetchSpecies();
  }

  Future<void> fetchSpecies() async {
    final url = Uri.parse('http://localhost:3003/home/species');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        setState(() {
          if (responseData is List) {
            speciesList = responseData;
          } else if (responseData is Map) {
            speciesList = [responseData];
          } else {
            speciesList = [];
          }
          isLoading = false;
        });
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al cargar especies: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth < 600)
        ? 2
        : (screenWidth < 900)
            ? 4
            : 5;

    final horizontalPadding = 125.0;
    final verticalPadding = 50.0;

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.backgroundColorDark
            : AppColors.backgroundColorLight,
        appBar: const AppNavbar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppHeader(
                imagePath:
                    'https://images.unsplash.com/photo-1695231054363-f149bb54841e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                title: 'Bienvenido al Álbum de Especies',
                subtitle: 'Explora nuestras especies disponibles.',
                height: 300,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : speciesList.isEmpty
                            ? _buildEmptyState(isDarkMode)
                            : StaggeredGrid.count(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                children: List.generate(speciesList.length, (index) {
                                  return _buildSpeciesCard(
                                    context,
                                    speciesList[index],
                                    isDarkMode,
                                  );
                                }),
                              ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),

              const AppFooter(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSpeciesCard(
      BuildContext context, dynamic speciesData, bool isDarkMode) {
    bool isHovered = false;
    final imageUrl = speciesData['mainImage'] ??
        ((speciesData['images'] is List && speciesData['images'].isNotEmpty)
            ? speciesData['images'][0]
            : '');

    return StatefulBuilder(
      builder: (context, setInnerState) {
        return MouseRegion(
          onEnter: (_) => setInnerState(() => isHovered = true),
          onExit: (_) => setInnerState(() => isHovered = false),
          child: GestureDetector(
            onTap: () => _navigateToSpeciesDetail(context, speciesData),
            child: Transform.scale(
              scale: isHovered ? 1.03 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black54 : Colors.black12,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (speciesData['family'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getFamilyColor(
                            speciesData['family'],
                            isDarkMode,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          speciesData['family'].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 100,
                          color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              color: isDarkMode ? Colors.white70 : Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      speciesData['commonName'] ?? 'Especie sin nombre',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      speciesData['scientificName'] ?? '',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: isDarkMode ? Colors.white54 : Colors.black54,
          ),
          const SizedBox(height: 20),
          Text(
            'No se encontraron especies',
            style: TextStyle(
              fontSize: 18,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSpeciesDetail(BuildContext context, dynamic speciesData) {
  // Convierte el Map a modelo Especie
  final especie = Especie.fromJson(speciesData is Map<String, dynamic> 
      ? speciesData 
      : {}); // Fallback seguro
  
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SpeciesFormat(especie: especie),
    ),
  );
}


  List<String> _parseCharacteristics(dynamic characteristics) {
    if (characteristics == null) return ['Características no disponibles'];
    if (characteristics is List) {
      return characteristics.map((e) => e.toString()).toList();
    }
    return [characteristics.toString()];
  }

  Color _getConservationColor(String? status, bool isDarkMode) {
    if (status == null) {
      return isDarkMode ? Colors.blueGrey[700]! : Colors.blueGrey[300]!;
    }

    switch (status.toUpperCase()) {
      case 'EXTINTA (EX)':
        return Colors.grey[900]!;
      case 'EXTINTA EN ESTADO SILVESTRE (EW)':
        return Colors.grey[700]!;
      case 'EN PELIGRO CRÍTICO (CR)':
        return Colors.red[800]!;
      case 'EN PELIGRO (EN)':
        return Colors.red[500]!;
      case 'VULNERABLE (VU)':
        return Colors.orange[400]!;
      case 'CASI AMENAZADA (NT)':
        return Colors.yellow[600]!;
      case 'PREOCUPACIÓN MENOR (LC)':
        return Colors.green[400]!;
      case 'DATOS INSUFICIENTES (DD)':
        return Colors.blueGrey[500]!;
      case 'NO EVALUADO (NE)':
        return isDarkMode ? Colors.blueGrey[700]! : Colors.blueGrey[300]!;
      default:
        return isDarkMode ? Colors.blueGrey[700]! : Colors.blueGrey[300]!;
    }
  }

  Color _getFamilyColor(String family, bool isDarkMode) {
    final familyUpper = family.toUpperCase();
    
    if (familyUpper.contains('MAMÍFEROS MARINOS')) return Colors.indigo;
    if (familyUpper.contains('PECES')) return Colors.teal;
    if (familyUpper.contains('MEDUSAS')) return Colors.purple;
    if (familyUpper.contains('MOLUSCOS')) return Colors.orange;
    if (familyUpper.contains('CRUSTÁCEOS')) return Colors.red[400]!;
    if (familyUpper.contains('AVES MARINAS')) return Colors.brown[400]!;
    if (familyUpper.contains('TORTUGAS MARINAS')) return Colors.green[600]!;
    if (familyUpper.contains('CORALES')) return Colors.pink[300]!;
    if (familyUpper.contains('EQUINODERMOS')) return Colors.cyan[400]!;
    
    return isDarkMode ? Colors.blueGrey[700]! : Colors.blueGrey[300]!;
  }

}
