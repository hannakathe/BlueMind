import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import 'document_format_view.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../models/blog_model.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _BlogListViewState();
}

class _BlogListViewState extends State<LibraryView> {
  List<BlogDocument> blogList = [];
  bool isLoading = true;
  String? errorMessage;

  final ThemeController themeController = Get.find<ThemeController>();
  final double horizontalPadding = 125.0;
  final double verticalPadding = 50.0;

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    final url = Uri.parse('http://localhost:3001/home/documents');
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        
        if (decodedData == null) {
          throw Exception('Response data is null');
        }

        setState(() {
          blogList = _parseBlogDocuments(decodedData);
          isLoading = false;
          errorMessage = null;
        });
      } else {
        throw Exception('Failed to load blogs: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Error loading blogs: $e');
      print('Stack trace: $stackTrace');
      
      setState(() {
        isLoading = false;
        errorMessage = 'Error al cargar los artículos. Intente nuevamente.';
      });
    }
  }

  List<BlogDocument> _parseBlogDocuments(dynamic data) {
    try {
      if (data is List) {
        return data.map<BlogDocument>((item) {
          try {
            return _parseBlogItem(item);
          } catch (e) {
            print('Error parsing blog item: $e');
            return _createErrorBlogDocument();
          }
        }).toList();
      } else if (data is Map<String, dynamic>) {
        return [_parseBlogItem(data)];
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      print('Error parsing blog documents: $e');
      return [];
    }
  }

  BlogDocument _parseBlogItem(dynamic item) {
    try {
      final Map<String, dynamic> jsonData = item is Map<String, dynamic> 
          ? item 
          : {};

      if (jsonData['content'] is String) {
        jsonData['content'] = {
          'introduccion': jsonData['content'],
          'causas_del_deterioro': {},
          'consecuencias_del_deterioro': {},
          'soluciones_y_estrategias': {},
          'conclusion': '',
          'fuentes_recomendadas': []
        };
      }

      return BlogDocument.fromJson(jsonData);
    } catch (e) {
      print('Error parsing blog item: $e');
      return _createErrorBlogDocument();
    }
  }

  BlogDocument _createErrorBlogDocument() {
    return BlogDocument(
      id: 'error',
      title: 'Error loading content',
      summary: 'Could not load this content',
      content: Content.fromJson({}),
      imageUrl: '',
      author: 'System',
      publishDate: DateTime.now(),
      lastUpdate: DateTime.now(),
      readTime: 0,
      category: 'Error',
      views: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;
      final backgroundColor = isDarkMode 
          ? AppColors.backgroundColorDark 
          : AppColors.backgroundColorLight;

      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: const AppNavbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AppHeader(
                imagePath: 'https://images.unsplash.com/photo-1695231054363-f149bb54841e',
                title: 'Blog de BlueMind',
                subtitle: 'Descubre artículos sobre la vida marina y conservación.',
                height: 300,
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _getAdjustedPadding(screenWidth, horizontalPadding),
                  vertical: verticalPadding,
                ),
                child: _buildContent(isDarkMode, screenWidth),
              ),
              
              const AppFooter(),
            ],
          ),
        ),
      );
    });
  }

  double _getAdjustedPadding(double screenWidth, double basePadding) {
    if (screenWidth < 600) return 20.0;
    if (screenWidth < 900) return 60.0;
    if (screenWidth < 1200) return 90.0;
    return basePadding;
  }

  Widget _buildContent(bool isDarkMode, double screenWidth) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (errorMessage != null) {
      return _buildErrorState(errorMessage!, isDarkMode);
    }
    
    if (blogList.isEmpty) {
      return _buildEmptyState(isDarkMode);
    }
    
    return StaggeredGrid.count(
      crossAxisCount: _calculateCrossAxisCount(screenWidth),
      mainAxisSpacing: 30,
      crossAxisSpacing: 30,
      children: blogList.map((blog) => _buildStaggeredTile(blog, screenWidth)).toList(),
    );
  }

  StaggeredGridTile _buildStaggeredTile(BlogDocument blog, double screenWidth) {
    // Asignamos diferentes tamaños basados en el índice para variedad
    final index = blogList.indexOf(blog);
    final isLarge = index % 5 == 0;  // Cada 5 items uno grande
    final isMedium = index % 3 == 0; // Cada 3 items uno mediano
    
    if (screenWidth < 600) {
      return StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _buildBlogCard(blog, isDarkMode: themeController.isDarkMode.value),
      );
    } else if (isLarge) {
      return StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 1.4,
        child: _buildBlogCard(blog, isDarkMode: themeController.isDarkMode.value, isLarge: true),
      );
    } else if (isMedium) {
      return StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1.2,
        child: _buildBlogCard(blog, isDarkMode: themeController.isDarkMode.value, isMedium: true),
      );
    } else {
      return StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _buildBlogCard(blog, isDarkMode: themeController.isDarkMode.value),
      );
    }
  }

  Widget _buildBlogCard(BlogDocument blog, {bool isDarkMode = false, bool isLarge = false, bool isMedium = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _navigateToBlogDetail(blog),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          child: SizedBox(
            width: isLarge ? 500 : (isMedium ? 350 : 320),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoría
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(blog.category, isDarkMode),
                      borderRadius: BorderRadius.circular(6),
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
                  const SizedBox(height: 15),
                  
                  // Imagen
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: isLarge ? 220 : (isMedium ? 200 : 180),
                      width: double.infinity,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      child: Image.network(
                        blog.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: isDarkMode ? Colors.white70 : Colors.black45,
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / 
                                    loadingProgress.expectedTotalBytes!
                                  : null,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Título
                  Text(
                    blog.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isLarge ? 22 : (isMedium ? 20 : 18),
                      color: isDarkMode ? Colors.white : Colors.black,
                      height: 1.3,
                    ),
                    maxLines: isLarge ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  
                  // Resumen
                  Text(
                    blog.summary,
                    style: TextStyle(
                      fontSize: isLarge ? 16 : 14,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                      height: 1.5,
                    ),
                    maxLines: isLarge ? 4 : (isMedium ? 3 : 2),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  
                  // Metadatos
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline, 
                        size: 14, 
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        blog.author,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time, 
                        size: 14, 
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${blog.readTime} min',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.remove_red_eye, 
                        size: 14, 
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${blog.views}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: isDarkMode ? Colors.white54 : Colors.black54,
          ),
          const SizedBox(height: 20),
          Text(
            'No se encontraron artículos',
            style: TextStyle(
              fontSize: 18,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: fetchBlogs,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Intentar nuevamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: isDarkMode ? Colors.red[300] : Colors.red,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: fetchBlogs,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  void _navigateToBlogDetail(BlogDocument blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DocumentDetailView(blog: blog),
      ),
    );
  }

  int _calculateCrossAxisCount(double screenWidth) {
    if (screenWidth < 600) return 1;
    if (screenWidth < 900) return 2;
    if (screenWidth < 1200) return 3;
    return 4;
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
}