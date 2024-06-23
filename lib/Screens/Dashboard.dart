import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:ui_level_up/Cards/CategoryCard.dart';
import 'package:ui_level_up/Models/ItemsClass.dart';
import 'package:ui_level_up/Screens/CategoryDetails.dart';

class Dashboards extends StatefulWidget {
  const Dashboards({super.key});

  @override
  State<Dashboards> createState() => _DashboardsState();
}

class _DashboardsState extends State<Dashboards> {
  Items? items;

  void fetchMealCategories() async {
    final response = await get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      setState(() {
        items = Items.fromJson(jsonResponse);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMealCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      print(items!.items.length);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Meal DB"),
          backgroundColor: Color.fromARGB(202, 74, 127, 170),
        ),
        body: items != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Choose Category"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items!.items.length,
                      itemBuilder: (context, index) {
                        // return Text(items!.items[index].strCategory);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => CategoryDetails(
                                    categoryName:
                                        items!.items[index].strCategory),
                              ),
                            );
                          },
                          child: CategoryCard(item: items!.items[index]),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
