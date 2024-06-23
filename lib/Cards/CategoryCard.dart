import 'package:flutter/material.dart';
import 'package:ui_level_up/Models/ItemsClass.dart';

class CategoryCard extends StatelessWidget {
  final Item item;
  const CategoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 5,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      borderOnForeground: true,
      child: Column(
        children: [
          Image.network(
            item.strCategoryThumb,
            alignment: Alignment.center,
            height: 200,
            width: 200,
          ),
          Text(
            item.strCategory,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
