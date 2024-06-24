import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ui_level_up/Models/MealDetailsClass.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MealRecipie extends StatefulWidget {
  final String id;
  const MealRecipie({super.key, required this.id});

  @override
  State<MealRecipie> createState() => _MealRecipieState();
}

class _MealRecipieState extends State<MealRecipie> {
  MealDetails? mealDetails;
  bool isLoading = true;
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
    super.initState();
    fetchMealRecipie();
  }

  void _showYouTubeVideo(BuildContext context, String videoId) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
        // enableCaption: true,
      ),
    );

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mealDetails != null ? mealDetails!.strMeal : "",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : mealDetails != null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                mealDetails!.strMealThumb,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Ingredients",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: mealDetails!.ingredients.length,
                              itemBuilder: (context, index) {
                                if (mealDetails!
                                    .ingredients[index].isNotEmpty) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mealDetails!.ingredients[index],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        mealDetails!.measures[index],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Recipe",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              mealDetails!.strInstructions,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            mealDetails!.strYoutube.isNotEmpty
                                ? ElevatedButton(
                                    onPressed: () {
                                      final videoId =
                                          YoutubePlayer.convertUrlToId(
                                              mealDetails!.strYoutube);
                                      if (videoId != null) {
                                        _showYouTubeVideo(context, videoId);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red, // Background color
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Watch Video",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Image.asset(
                                          "assets/youtube.png",
                                          height: 24,
                                          width: 24,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
    );
  }
}
