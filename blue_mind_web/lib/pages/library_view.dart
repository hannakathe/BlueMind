import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart';
import 'document_format_view.dart';
import '../widgets/app_footer.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final ThemeController themeController = Get.find();

  List<dynamic> documents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    final url = Uri.parse('http://localhost:3001/home/documents');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          documents = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al cargar documentos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 125.0;
    final verticalPadding = 50.0;

    return Obx(() {
      final bool isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark
            ? AppColors.backgroundColorDark
            : AppColors.backgroundColorLight,
        appBar: const AppNavbar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header fuera del padding
              const AppHeader(
                imagePath:
                    'https://images.unsplash.com/photo-1596952687581-9bd164398339?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                title: 'Bienvenido a la librería de recursos educativos',
                subtitle: 'Explora nuestros documentos disponibles.',
                height: 300,
              ),

              // Contenido con padding
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
                        : StaggeredGrid.count(
                            crossAxisCount: 8,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: List.generate(documents.length, (index) {
                              final doc = documents[index];
                              final isLarge = index % 5 == 0;
                              final cross = isLarge ? 4 : 2;
                              final main = (isLarge ? 3 : 2).toDouble();

                              return _buildTile(context, doc, cross, main, isDark);
                            }),
                          ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),

              // Footer fuera del padding
              const AppFooter(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTile(
    BuildContext context,
    dynamic doc,
    int crossAxisCellCount,
    double mainAxisCellCount,
    bool isDark,
  ) {
    bool isHovered = false;
    final tileBackgroundColor = isDark ? Colors.grey[900] : Colors.white;
    final shadowColor = isDark ? Colors.black54 : Colors.black12;
    final summaryColor = isDark ? Colors.white70 : Colors.black54;
    final summaryHoverColor = isDark ? Colors.white : Colors.black87;
    final titleColor = isDark ? Colors.white : Colors.black87;

    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: StatefulBuilder(
        builder: (context, setInnerState) {
          return MouseRegion(
            onEnter: (_) => setInnerState(() => isHovered = true),
            onExit: (_) => setInnerState(() => isHovered = false),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DocumentDetailView(document: doc),
                ),
              ),
              child: Transform.scale(
                scale: isHovered ? 1.03 : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tileBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: shadowColor, blurRadius: 6)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          doc['imageUrl'],
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 100,
                            color: isDark ? Colors.grey[800] : Colors.grey[300],
                            child:
                                const Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        doc['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: titleColor),
                      ),
                      const SizedBox(height: 4),
                      AnimatedCrossFade(
                        firstChild: Text(
                          doc['summary'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: summaryColor, fontSize: 12),
                        ),
                        secondChild: Text(
                          doc['summary'],
                          style: TextStyle(color: summaryHoverColor, fontSize: 12),
                        ),
                        crossFadeState: isHovered
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.download,
                                size: 18,
                                color: isDark ? Colors.white70 : Colors.black54),
                            onPressed: () {
                              // Acción descarga
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
