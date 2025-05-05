import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_filter.dart'; // Importamos el filtro

class AlbumView extends StatefulWidget {
  const AlbumView({super.key});

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  String selectedCategory = 'Todos';

  final List<String> categories = [
    'Todos',
    'Mamiferos Marinos',
    'Peces',
    'Reptiles Marinos',
    'Moluscos',
    'Crustaceos',
    'Otros'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(),
      body: Column(
        children: [
          // Usamos el componente SpeciesFilter importado
          SpeciesFilter(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          // Grid de especies
          Expanded(child: _buildSpeciesGrid()),
        ],
      ),
    );
  }

  Widget _buildSpeciesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = 150.0;
        final verticalPadding = 200.0;
        final availableWidth = constraints.maxWidth - (horizontalPadding * 2);
        final size = availableWidth / 4.3;
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: GridView.builder(
            padding: EdgeInsets.only(top: 8.0, bottom: verticalPadding),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 1,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return SpeciesCard(
                size: size,
                title: 'Esp ${index + 1}',
                category: categories[(index % categories.length).clamp(1, categories.length - 1)],
                imageUrl: 'https://picsum.photos/200?random=$index',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpeciesDetailView(
                        title: 'Especie ${index + 1}',
                        imageUrl: 'https://picsum.photos/400?random=$index',
                        description: 'Descripción detallada de la especie ${index + 1}...',
                        category: categories[(index % categories.length).clamp(1, categories.length - 1)],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class SpeciesCard extends StatelessWidget {
  final double size;
  final String title;
  final String category; // Añadimos este parámetro
  final String imageUrl;
  final VoidCallback onTap;

  const SpeciesCard({
    super.key,
    required this.size,
    required this.title,
    required this.category, // Lo añadimos al constructor
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onTap,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge de categoría
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    category.split(' ').first,
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Parte de la imagen
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.pets, size: 30),
                    ),
                  ),
                ),
              ),
              // Parte del nombre
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeciesDetailView extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String category; // Asegurarse que está declarado aquí

  const SpeciesDetailView({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.category, // Y en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Icon(Icons.pets, size: 60),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Mostrar la categoría
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Descripción:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 16.0),
            const Text(
              'Características:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text('- Hábitat natural\n- Dieta\n- Tamaño promedio\n- Esperanza de vida'),
          ],
        ),
      ),
    );
  }
}