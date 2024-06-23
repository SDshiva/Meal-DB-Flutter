import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_level_up/Models/MealClass.dart'; // Ensure Meal class is correctly imported

class CategoryDetails extends StatefulWidget {
  final String categoryName;

  const CategoryDetails({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails>
    with SingleTickerProviderStateMixin {
  List<Meal>? meals;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust duration as needed
    );

    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.bounceOut // Adjust curve as needed
        );

    fetchCategoryDetails(); // Initiate data fetching and animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose animation controller
    super.dispose();
  }

  Future<void> fetchCategoryDetails() async {
    final response = await http.get(
      Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.categoryName}"),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        meals = (jsonResponse['meals'] as List)
            .map((mealJson) => Meal.fromJson(mealJson))
            .toList();
      });

      _animationController.forward();
      // _animationController.reverse();
      // period: Duration(seconds: 2), reverse: true); // Start the animation
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Color.fromARGB(202, 74, 127, 170),
      ),
      body: meals != null
          ? ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: meals!.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Card(
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network(
                                meals![index].strMealThumb,
                                fit: BoxFit.cover,
                                height: 250,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                meals![index].strMeal,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}