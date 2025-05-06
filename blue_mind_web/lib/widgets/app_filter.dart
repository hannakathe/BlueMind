import 'package:flutter/material.dart';

class SpeciesFilter extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const SpeciesFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 10.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(categories[index]),
              selected: selectedCategory == categories[index],
              onSelected: (bool selected) {
                onCategorySelected(selected ? categories[index] : 'Todos');
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.blue[200],
              labelStyle: TextStyle(
                color: selectedCategory == categories[index] 
                    ? Colors.blue[800] 
                    : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}