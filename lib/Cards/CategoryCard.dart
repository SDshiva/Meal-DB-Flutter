import 'package:flutter/material.dart';
import 'package:ui_level_up/Models/ItemsClass.dart';

class CategoryCard extends StatelessWidget {
  final Item item;
  const CategoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
              bottom: Radius.circular(15),
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.network(
                    item.strCategoryThumb,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Colors.orangeAccent.withOpacity(0.6),
                    //     Colors.transparent,
                    //   ],
                    //   begin: Alignment.bottomCenter,
                    //   end: Alignment.topCenter,
                    //   // transform: GradientRotation(1),
                    // ),
                    color: Colors.transparent,
                    // color: Colors.blueAccent.withOpacity(100),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    item.strCategory,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 5,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
