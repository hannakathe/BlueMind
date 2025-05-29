import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/educational_resource_model.dart';
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

class MarineResourceDetailView extends StatelessWidget {
  final EducationalResource resource;

  const MarineResourceDetailView({Key? key, required this.resource}) : super(key: key);

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
                          imageUrl: resource.imageUrl,
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
                          color: _getCategoryColor(resource.subject, isDarkMode),
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
                          resource.subject.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getLevelColor(resource.educationalLevel, isDarkMode),
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
                          resource.educationalLevel.toUpperCase(),
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

                // Título del recurso
                Text(
                  resource.title,
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
                      resource.author,
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
                      '${resource.publishDate.day}/${resource.publishDate.month}/${resource.publishDate.year}',
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
                      '${resource.estimatedTime} min estimados',
                      style: AppTypography.textoSecundario.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Resumen del recurso
                Text(
                  resource.summary,
                  style: AppTypography.parrafos.copyWith(
                    color: textColor,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 30),

                // Contenido estructurado
                _buildContent(resource.content, textColor),

                const SizedBox(height: 30),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: resource.tags
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
                if (resource.galleryImages.isNotEmpty) ...[
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
                      children: resource.galleryImages
                          .map<Widget>((url) => _buildGalleryImage(url, isDarkMode))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],

                // Recursos relacionados
                if (resource.relatedResources.isNotEmpty) ...[
                  Text(
                    'Recursos relacionados',
                    style: AppTypography.h2SubtitulosImportantes.copyWith(
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: resource.relatedResources
                          .map<Widget>((res) => _buildRelatedResource(res, isDarkMode))
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
        _buildSection('Introducción', content.introduction, textColor),
        const SizedBox(height: 30),

        // Objetivos de aprendizaje
        _buildSection('Objetivos de Aprendizaje', '', textColor),
        const SizedBox(height: 15),
        _buildLearningObjectives(content.learningObjectives, textColor),
        const SizedBox(height: 30),

        // Conceptos clave
        _buildSection('Conceptos Clave', '', textColor),
        const SizedBox(height: 15),
        _buildKeyConcepts(content.keyConcepts, textColor),
        const SizedBox(height: 30),

        // Actividades
        _buildSection('Actividades', '', textColor),
        const SizedBox(height: 15),
        _buildActivities(content.activities, textColor),
        const SizedBox(height: 30),

        // Conclusión
        _buildSection('Conclusión', content.conclusion, textColor),
        const SizedBox(height: 20),

        // Recursos adicionales
        if (content.additionalResources.isNotEmpty) ...[
          Text(
            'Recursos Adicionales:',
            style: AppTypography.h2SubtitulosImportantes.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.additionalResources
                .map<Widget>((recurso) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.link,
                              size: 16,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              recurso,
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

  Widget _buildLearningObjectives(LearningObjectives objectives, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildObjectiveList('Conocimientos', objectives.knowledgeObjectives, textColor),
        const SizedBox(height: 20),
        _buildObjectiveList('Habilidades', objectives.skillObjectives, textColor),
        const SizedBox(height: 20),
        _buildObjectiveList('Actitudes', objectives.attitudeObjectives, textColor),
      ],
    );
  }

  Widget _buildObjectiveList(String title, List<String> objectives, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.h2SubtitulosImportantes.copyWith(
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: objectives
              .map<Widget>((obj) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4, right: 8),
                          child: Icon(
                            Icons.emoji_objects_outlined,
                            size: 16,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            obj,
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

  Widget _buildKeyConcepts(KeyConcepts concepts, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          concepts.mainConcept,
          style: AppTypography.parrafos.copyWith(
            color: textColor,
            height: 1.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        
        if (concepts.secondaryConcepts.isNotEmpty) ...[
          Text(
            'Conceptos Secundarios:',
            style: AppTypography.h2SubtitulosImportantes.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: concepts.secondaryConcepts
                .map<Widget>((concept) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.arrow_right,
                              size: 16,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              concept,
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
          const SizedBox(height: 15),
        ],
        
        if (concepts.vocabulary.isNotEmpty) ...[
          Text(
            'Vocabulario:',
            style: AppTypography.h2SubtitulosImportantes.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: concepts.vocabulary
                .map<Widget>((word) => Chip(
                      label: Text(
                        word,
                        style: AppTypography.textoSecundario.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildActivities(Activities activities, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildActivityList('Actividades de Introducción', 
            activities.introductoryActivities, textColor),
        const SizedBox(height: 20),
        _buildActivityList('Actividades de Desarrollo', 
            activities.developmentActivities, textColor),
        const SizedBox(height: 20),
        _buildActivityList('Actividades de Evaluación', 
            activities.evaluationActivities, textColor),
        const SizedBox(height: 20),
        _buildActivityList('Actividades de Extensión', 
            activities.extensionActivities, textColor),
      ],
    );
  }

  Widget _buildActivityList(String title, List<Activity> activities, Color textColor) {
    if (activities.isEmpty) return const SizedBox.shrink();
    
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
        ...activities.map((activity) => _buildActivityCard(activity, textColor)),
      ],
    );
  }

  Widget _buildActivityCard(Activity activity, Color textColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.title,
              style: AppTypography.h2SubtitulosImportantes.copyWith(
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            
            if (activity.description.isNotEmpty) ...[
              Text(
                activity.description,
                style: AppTypography.parrafos.copyWith(
                  color: textColor,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
            ],
            
            Text(
              'Instrucciones:',
              style: AppTypography.parrafos.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              activity.instructions,
              style: AppTypography.parrafos.copyWith(
                color: textColor,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: textColor.withOpacity(0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  activity.duration,
                  style: AppTypography.textoSecundario.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
            
            if (activity.materials.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Materiales:',
                style: AppTypography.parrafos.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: activity.materials
                    .map<Widget>((material) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
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
                                  material,
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
            
            if (activity.evaluationCriteria.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Criterios de Evaluación:',
                style: AppTypography.parrafos.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                activity.evaluationCriteria,
                style: AppTypography.parrafos.copyWith(
                  color: textColor,
                  height: 1.6,
                ),
              ),
            ],
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

  Widget _buildRelatedResource(ResourceReference res, bool isDarkMode) {
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
                  imageUrl: res.imageUrl,
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
              res.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              res.resourceType.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category, bool isDarkMode) {
    final categoryUpper = category.toUpperCase();
    
    if (categoryUpper.contains('ECOSISTEMAS')) return Colors.green;
    if (categoryUpper.contains('ESPECIES')) return Colors.purple;
    if (categoryUpper.contains('CONSERVACIÓN')) return Colors.teal;
    if (categoryUpper.contains('OCEANOGRAFÍA')) return Colors.blue;
    if (categoryUpper.contains('CONTAMINACIÓN')) return Colors.orange;
    if (categoryUpper.contains('CAMBIOCLIMÁTICO')) return Colors.red;
    if (categoryUpper.contains('BIODIVERSIDAD')) return const Color(0xFF4CAF50);
    if (categoryUpper.contains('PESCA')) return const Color(0xFF2196F3);
    if (categoryUpper.contains('ARRECIFES')) return const Color(0xFFFF9800);
    
    return isDarkMode ? Colors.blueGrey[700]! : Colors.blueGrey[300]!;
  }

  Color _getLevelColor(String level, bool isDarkMode) {
    final levelUpper = level.toUpperCase();
    
    if (levelUpper.contains('BÁSICO') || levelUpper.contains('PRIMARIA')) return Colors.green;
    if (levelUpper.contains('INTERMEDIO') || levelUpper.contains('SECUNDARIA')) return Colors.blue;
    if (levelUpper.contains('AVANZADO') || levelUpper.contains('UNIVERSIDAD')) return Colors.purple;
    
    return isDarkMode ? Colors.blueGrey[500]! : Colors.blueGrey[400]!;
  }

  Color _getTagColor(String tag, bool isDarkMode) {
    // Genera un color basado en el hash del tag para consistencia
    final int hash = tag.hashCode;
    final int hue = (hash % 360).abs();
    return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.7, 0.5).toColor();
  }
}