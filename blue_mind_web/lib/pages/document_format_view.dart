import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/blog_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class DocumentDetailView extends StatelessWidget {
  final BlogDocument blog;

  const DocumentDetailView({Key? key, required this.blog}) : super(key: key);

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
                // Imagen principal con etiqueta de categoría
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
                          imageUrl: blog.imageUrl,
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
                          color: _getCategoryColor(blog.category, isDarkMode),
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
                          blog.category.toUpperCase(),
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

                // Título del blog
                Text(
                  blog.title,
                  style: AppTypography.h1TitulosPrincipales.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),

                // Información del autor y fecha
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16,
                      color: secondaryTextColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      blog.author,
                      style: AppTypography.textoSecundario.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: secondaryTextColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${blog.publishDate.day}/${blog.publishDate.month}/${blog.publishDate.year}',
                      style: AppTypography.textoSecundario.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: secondaryTextColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${blog.readTime} min de lectura',
                      style: AppTypography.textoSecundario.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Resumen del blog
                Text(
                  blog.summary,
                  style: AppTypography.parrafos.copyWith(
                    color: textColor,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 30),

                // Contenido estructurado
                _buildContent(blog.content, textColor),

                const SizedBox(height: 30),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: blog.tags
                      .map<Widget>((tag) => Chip(
                            label: Text(
                              tag,
                              style: AppTypography.textoSecundario.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: _getTagColor(tag, isDarkMode),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 30),

                // Galería (solo si hay imágenes)
                if (blog.galleryImages.isNotEmpty) ...[
                  Text(
                    'Galería de Imágenes',
                    style: AppTypography.h2SubtitulosImportantes.copyWith(
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 450,
                    
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: blog.galleryImages
                          .map<Widget>((url) => _buildGalleryImage(url, isDarkMode))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],

                // Documentos relacionados
                if (blog.relatedDocuments.isNotEmpty) ...[
                  Text(
                    'Artículos relacionados',
                    style: AppTypography.h2SubtitulosImportantes.copyWith(
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: blog.relatedDocuments
                          .map<Widget>((doc) => _buildRelatedDocument(doc, isDarkMode))
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

  Widget _buildContent(Content content, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Introducción
        _buildSection('Introducción', content.introduccion, textColor),
        const SizedBox(height: 30),

        // Causas del deterioro
        _buildSection('Causas del Deterioro', '', textColor),
        const SizedBox(height: 15),
        _buildCause(content.causasDelDeterioro.aumentoTemperaturaMar, textColor),
        const SizedBox(height: 20),
        _buildCause(content.causasDelDeterioro.acidificacionOceanica, textColor),
        const SizedBox(height: 20),
        _buildCause(content.causasDelDeterioro.fenomenosMeteorologicosExtremos, textColor),
        const SizedBox(height: 15),
        if (content.causasDelDeterioro.otrasAmenazas.isNotEmpty) ...[
          Text(
            'Otras Amenazas:',
            style: AppTypography.h2SubtitulosImportantes.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.causasDelDeterioro.otrasAmenazas
                .map<Widget>((amenaza) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.circle,
                              size: 8,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              amenaza,
                              style: AppTypography.parrafos.copyWith(
                                color: textColor,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 30),
        ],

        // Consecuencias del deterioro
        _buildSection('Consecuencias del Deterioro', '', textColor),
        const SizedBox(height: 15),
        Text(
          content.consecuenciasDelDeterioro.perdidaBiodiversidad,
          style: AppTypography.parrafos.copyWith(
            color: textColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        _buildImpact(content.consecuenciasDelDeterioro.impactoEconomico, textColor),
        const SizedBox(height: 20),
        _buildRisk(content.consecuenciasDelDeterioro.aumentoRiesgoCostero, textColor),
        const SizedBox(height: 30),

        // Soluciones y estrategias
        _buildSection('Soluciones y Estrategias', '', textColor),
        const SizedBox(height: 15),
        _buildSolutionList('Mitigación del Cambio Climático', 
            content.solucionesYStrategias.mitigacionCambioClimatico, textColor),
        const SizedBox(height: 20),
        _buildSolutionList('Protección y Restauración', 
            content.solucionesYStrategias.proteccionRestauracion, textColor),
        const SizedBox(height: 20),
        _buildSolutionList('Investigación y Monitoreo', 
            content.solucionesYStrategias.investigacionMonitoreo, textColor),
        const SizedBox(height: 30),

        // Conclusión
        _buildSection('Conclusión', content.conclusion, textColor),
        const SizedBox(height: 20),

        // Fuentes recomendadas
        if (content.fuentesRecomendadas.isNotEmpty) ...[
          Text(
            'Fuentes Recomendadas:',
            style: AppTypography.h2SubtitulosImportantes.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.fuentesRecomendadas
                .map<Widget>((fuente) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.circle,
                              size: 8,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              fuente,
                              style: AppTypography.parrafos.copyWith(
                                color: textColor,
                                height: 1.6,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildSection(String title, String content, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.h2SubtitulosImportantes.copyWith(
            color: textColor,
          ),
        ),
        if (content.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            content,
            style: AppTypography.parrafos.copyWith(
              color: textColor,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCause(dynamic cause, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cause.descripcion,
          style: AppTypography.parrafos.copyWith(
            color: textColor,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cause.efectos
              .map<Widget>((efecto) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4, right: 8),
                          child: Icon(
                            Icons.circle,
                            size: 8,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            efecto,
                            style: AppTypography.parrafos.copyWith(
                              color: textColor,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildImpact(EconomicImpact impact, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Impacto Económico:',
          style: AppTypography.h2SubtitulosImportantes.copyWith(
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          impact.descripcion,
          style: AppTypography.parrafos.copyWith(
            color: textColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          impact.efectos,
          style: AppTypography.parrafos.copyWith(
            color: textColor,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildRisk(CoastalRisk risk, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aumento del Riesgo Costero:',
          style: AppTypography.h2SubtitulosImportantes.copyWith(
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          risk.descripcion,
          style: AppTypography.parrafos.copyWith(
            color: textColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          risk.efectos,
          style: AppTypography.parrafos.copyWith(
            color: textColor,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSolutionList(String title, List<String> solutions, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.h2SubtitulosImportantes.copyWith(
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: solutions
              .map<Widget>((solution) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4, right: 8),
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            solution,
                            style: AppTypography.parrafos.copyWith(
                              color: textColor,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
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

  Widget _buildRelatedDocument(DocumentReference doc, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: doc.imageUrl,
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
            const SizedBox(height: 8),
            Text(
              doc.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category, bool isDarkMode) {
    final categoryUpper = category.toUpperCase();
    
    if (categoryUpper.contains('CONSERVACIÓN')) return Colors.green;
    if (categoryUpper.contains('INVESTIGACIÓN')) return Colors.blue;
    if (categoryUpper.contains('AVENTURAS')) return Colors.orange;
    if (categoryUpper.contains('ESPECIES')) return Colors.purple;
    if (categoryUpper.contains('ECOSISTEMAS')) return Colors.teal;
    if (categoryUpper.contains('NOTICIAS')) return Colors.red;
    if (categoryUpper.contains('CIENCIA MARINA')) return const Color.fromARGB(255, 226, 110, 1);
    if (categoryUpper.contains('HISTORIA MARINA')) return const Color.fromARGB(255, 176, 8, 218);
    if (categoryUpper.contains('TECNOLOGÍA MARINA')) return const Color.fromARGB(255, 17, 2, 226);
    
    return isDarkMode ? Colors.blueGrey[700]! : Colors.blueGrey[300]!;
  }

  Color _getTagColor(String tag, bool isDarkMode) {
    // Genera un color basado en el hash del tag para consistencia
    final int hash = tag.hashCode;
    final int hue = (hash % 360).abs();
    return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.7, 0.5).toColor();
  }
}