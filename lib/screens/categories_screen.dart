import 'package:flutter/material.dart';
import 'package:project_flutter/screens/chat_screen.dart';
import 'package:project_flutter/screens/vote_screen.dart';
import '../app_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'Categories_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 252, 195),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Row(children: [
          Image.asset(
            'images/books.png',
            height: 25,
          ),
          const SizedBox(
            width: 25,
          ),
          const Text(
            'Tableau De bord Des Cours',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )
        ]),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10), // Ajout des marges verticales et horizontales
        child: GridView(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 7 / 8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: Categories_data.map(
            (categoryData) => CategoryItem(
              categoryData.id,
              categoryData.title,
              categoryData.imageUrl,
            ),
          ).toList(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            vertical:
                8), // Ajout d'une marge verticale entre la grille et les boutons
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 200, // Largeur personnalisée pour le bouton 1
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ChatScreen.screenRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 52, 114, 237), // Couleur rose
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Discussion',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200, // Largeur personnalisée pour le bouton 2
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, VoteScreen.screenRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 198, 42, 53), // Couleur rose
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Vote',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
