import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ui_level_up/Models/MealDetailsClass.dart';

class MealRecipie extends StatefulWidget {
  final String id;
  const MealRecipie({super.key, required this.id});

  @override
  State<MealRecipie> createState() => _MealRecipieState();
}

class _MealRecipieState extends State<MealRecipie> {
  MealDetails? mealDetails;
  bool isLoading = false;
  String? errorMessage;

  fetchMealRecipie() async {
    try {
      final response = await get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.id}"));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          mealDetails =
              MealDetails.fromJson((jsonResponse['meals'] as List).first);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load data";
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = "An error occurred";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMealRecipie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetails != null ? mealDetails!.strMeal : ""),
        backgroundColor: Color.fromARGB(202, 74, 127, 170),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : mealDetails != null
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.network(mealDetails!.strMealThumb),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              mealDetails!.strInstructions,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          // Add more widgets to display other meal details
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
    );
  }
}
