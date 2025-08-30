import 'package:colorgeneratorapp/utils/colors_utils.dart';
import 'package:colorgeneratorapp/widgets/custom_drawer.dart';
import 'package:colorgeneratorapp/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentColorCode = 0;
  final List<Color> favoritesList = [];

  void generateColor() {
    setState(() {
      currentColorCode = nextColorCode(currentColorCode);
    });
  }

  void reset() {
    setState(() {
      currentColorCode = 0;
      favoritesList.clear();
    });
  }

  void addToFavorites() {
    final currentColor = colorFromCode(currentColorCode);
    if (favoritesList.contains(currentColor)) return;
    {
      setState(() {
        favoritesList.add(currentColor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = colorFromCode(currentColorCode);

    return GestureDetector(
      onTap: generateColor,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: currentColor,
        drawer: CustomDrawer(
          favoritesList: favoritesList,
          onFavoriteColorSelected: (Color selectedColor) {
            setState(() {
              currentColorCode =
                  ((selectedColor.r * 255).round() & 0xFF) << 16 |
                  ((selectedColor.g * 255).round() & 0xFF) << 8 |
                  ((selectedColor.b * 255).round() & 0xFF);
            });
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            iconSize: 35,
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.favorite, color: Colors.white),
          ),
        ),
        body: Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hello there..',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Tap anywhere to change the color',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomElevatedButton(onPressed: reset, title: 'Reset'),
                      CustomElevatedButton(
                        onPressed: addToFavorites,
                        title: 'Add to favorites',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
