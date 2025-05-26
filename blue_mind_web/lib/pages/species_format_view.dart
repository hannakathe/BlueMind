import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/species_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';

// Comportamiento personalizado para ocultar las barras de scroll
class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

// Widget principal que carga el JSON
class SpeciesScreen extends StatefulWidget {
  final String jsonResponse;

  const SpeciesScreen({Key? key, required this.jsonResponse}) : super(key: key);

  @override
  State<SpeciesScreen> createState() => _SpeciesScreenState();
}

class _SpeciesScreenState extends State<SpeciesScreen> {
  late Especie especie;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEspecie();
  }

  void _loadEspecie() {
    final Map<String, dynamic> jsonMap = jsonDecode(widget.jsonResponse);
    especie = Especie.fromJson(jsonMap);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return SpeciesFormat(especie: especie);
  }
}

// Widget que muestra la información de la especie
class SpeciesFormat extends StatelessWidget {
  final Especie especie;

  const SpeciesFormat({Key? key, required this.especie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final horizontalPadding = 125.0;
    final verticalPadding = 50.0;

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;
      final backgroundColor = isDarkMode
          ? AppColors.backgroundColorDark
          : AppColors.backgroundColorLight;
      final appBarColor = isDarkMode
          ? AppColors.navbarColorDark
          : AppColors.navbarColorLight;
      final textColor =
          isDarkMode ? AppColors.textColorDark : AppColors.textColorLight;
      final secondaryTextColor =
          isDarkMode ? Colors.white70 : Colors.black54;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 0,
          title: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  isDarkMode ? 'assets/logoW-invert.png' : 'assets/logoW.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'BlueMind',
                  style: AppTypography.blueMindtitle.copyWith(
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          iconTheme: IconThemeData(color: textColor),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: textColor,
                ),
                onPressed: themeController.toggleTheme,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        body: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen principal con etiqueta de familia
                Stack(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: especie.mainImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getFamilyColor(especie.family, isDarkMode),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          especie.family.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Nombre común y científico
                Text(
                  especie.commonName,
                  style: AppTypography.h1TitulosPrincipales.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  especie.scientificName,
                  style: AppTypography.textoSecundario.copyWith(
                    color: secondaryTextColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),

                // Chips con estado de conservación y familia
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: Text(
                        especie.conservationStatus,
                        style: AppTypography.textoSecundario.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: _getConservationColor(
                        especie.conservationStatus,
                        isDarkMode,
                      ),
                    ),
                    Chip(
                      label: Text(
                        especie.family,
                        style: AppTypography.textoSecundario.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: _getFamilyColor(
                        especie.family,
                        isDarkMode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Descripción
                Text(
                  'Descripción',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  especie.description,
                  style: AppTypography.parrafos.copyWith(color: textColor),
                ),
                const SizedBox(height: 30),

                // Distribución
                Text(
                  'Distribución',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  especie.distribution,
                  style: AppTypography.parrafos.copyWith(color: textColor),
                ),
                const SizedBox(height: 30),

                // Características físicas
                Text(
                  'Características Físicas',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInfoItem('Longitud:', especie.physicalCharacteristics.length, textColor),
                _buildInfoItem('Peso:', especie.physicalCharacteristics.weight, textColor),
                _buildInfoItem('Coloración:', especie.physicalCharacteristics.coloration, textColor),
                _buildInfoItem('Esperanza de vida:', especie.physicalCharacteristics.lifespan, textColor),
                const SizedBox(height: 30),

                // Comportamiento
                Text(
                  'Comportamiento',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInfoItem('Estructura social:', especie.behavior.socialStructure, textColor),
                _buildInfoItem('Comunicación:', especie.behavior.communication, textColor),
                _buildInfoItem('Inteligencia:', especie.behavior.intelligence, textColor),
                _buildInfoItem('Juego:', especie.behavior.playfulness, textColor),
                const SizedBox(height: 30),

                // Dieta y alimentación
                Text(
                  'Dieta y Alimentación',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInfoItem('Hábitos alimenticios:', especie.dietAndFeeding.feedingHabits, textColor),
                _buildInfoItem('Técnicas de caza:', especie.dietAndFeeding.huntingTechniques, textColor),
                _buildInfoItem('Consumo diario:', especie.dietAndFeeding.dailyConsumption, textColor),
                const SizedBox(height: 30),

                // Reproducción
                Text(
                  'Reproducción',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInfoItem('Gestación:', especie.reproduction.gestation, textColor),
                _buildInfoItem('Crías:', especie.reproduction.calves, textColor),
                _buildInfoItem('Periodo de lactancia:', especie.reproduction.nursingPeriod, textColor),
                _buildInfoItem('Madurez:', especie.reproduction.maturity, textColor),
                const SizedBox(height: 30),

                // Depredadores y amenazas
                Text(
                  'Depredadores y Amenazas',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Depredadores naturales:',
                  style: AppTypography.parrafos.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...especie.predators.naturalPredators.map(
                  (predator) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.circle, size: 8, color: textColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            predator,
                            style: AppTypography.parrafos.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Amenazas humanas:',
                  style: AppTypography.parrafos.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...especie.predators.threatsFromHumans.map(
                  (threat) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.circle, size: 8, color: textColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            threat,
                            style: AppTypography.parrafos.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Esfuerzos de conservación
                Text(
                  'Esfuerzos de Conservación',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInfoItem('Protección legal:', especie.conservationEfforts.legalProtection, textColor),
                _buildInfoItem('Investigación y monitoreo:', especie.conservationEfforts.researchAndMonitoring, textColor),
                _buildInfoItem('Áreas marinas protegidas:', especie.conservationEfforts.marineProtectedAreas, textColor),
                const SizedBox(height: 30),

                // Datos curiosos
                Text(
                  'Datos Curiosos',
                  style: AppTypography.h2SubtitulosImportantes.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                ...especie.funFacts.map(
                  (fact) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.yellow[700]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            fact,
                            style: AppTypography.parrafos.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Galería (solo si hay más de una imagen)
                if (especie.images.length > 1) ...[
                  Text(
                    'Galería de Imágenes',
                    style: AppTypography.h2SubtitulosImportantes.copyWith(
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: especie.images
                          .map((url) => _buildGalleryImage(url, isDarkMode))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInfoItem(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        text: TextSpan(
          style: AppTypography.parrafos.copyWith(color: textColor),
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryImage(String imageUrl, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            errorWidget: (context, url, error) => Center(
              child: Icon(
                Icons.image_not_supported,
                size: 40,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getConservationColor(String status, bool isDarkMode) {
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