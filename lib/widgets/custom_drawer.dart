import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<Color> favoritesList;
  final Function(Color) onFavoriteColorSelected;
  const CustomDrawer({
    required this.favoritesList,
    required this.onFavoriteColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Center(
              child: Text(
                'Favorite Colors',
                style: TextStyle(
                  color: Color(0xfff5f5f5),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: favoritesList.isEmpty
                ? const Text(
                    'No favorites yet..',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : ListView.builder(
                    itemCount: favoritesList.length,
                    itemBuilder: (context, index) {
                      final color = favoritesList[index];
                      final hex =
                          '#${(color.r * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
                          '${(color.g * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
                          '${(color.b * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}';

                      return GestureDetector(
                        onTap: () {
                          onFavoriteColorSelected(color);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            hex,
                            style: const TextStyle(
                              color: Color(0xfff5f5f5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
