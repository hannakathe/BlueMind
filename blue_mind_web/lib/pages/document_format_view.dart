import 'package:flutter/material.dart';

class DocumentDetailView extends StatelessWidget {
  final Map<String, dynamic> document;

  const DocumentDetailView({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> distribucion = document['distribucion'] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen principal
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              image: document['imagenPrincipal'] != null
                  ? DecorationImage(
                      image: NetworkImage(document['imagenPrincipal']),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 8),

          // Título e ícono
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                document['title'] ?? 'Sin título',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              
            ],
          ),
          const SizedBox(height: 16),

          _buildLabelText("Clasificación:", document['clasificacion'] ?? 'No disponible'),
          _buildLabelText("Hábitat:", document['habitat'] ?? 'No disponible'),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Distribución:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return Expanded(
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: distribucion.length > index && distribucion[index] != null
                        ? DecorationImage(
                            image: NetworkImage(distribucion[index]),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 16),
          _buildLabelText("Alimentación:", document['alimentacion'] ?? 'No disponible'),
          _buildLabelText("Nivel de amenaza:", document['nivelAmenaza'] ?? 'No disponible'),
          _buildLabelText("Características físicas:", document['caracteristicasFisicas'] ?? 'No disponible'),

          const SizedBox(height: 8),
          Text(
            document['descripcion1'] ?? '',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            document['descripcion2'] ?? '',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  static Widget _buildLabelText(String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
