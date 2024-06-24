import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_level_up/Models/MealClass.dart';
import 'package:ui_level_up/Screens/MealRecipie.dart'; // Ensure Meal class is correctly imported

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
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
      ),
      body: meals != null
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[50]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: meals!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) =>
                              MealRecipie(id: meals![index].idMeal),
                        ),
                      );
                    },
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _animation,
                          child: Transform.scale(
                            scale: _animation.value,
                            child: Card(
                              elevation: 10,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      meals![index].strMealThumb,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      meals![index].strMeal,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
