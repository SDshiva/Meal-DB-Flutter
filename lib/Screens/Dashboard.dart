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
          title: Text(
            "Smart Recipe Book",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        // endDrawer: Drawer(
        //   elevation: 5,
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       Container(
        //         height: 100, // Adjust the height to reduce the size
        //         child: DrawerHeader(
        //           padding: EdgeInsets.only(left: 10),
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //           ),
        //           child: Align(
        //             alignment: Alignment.centerLeft,
        //             child: Text(
        //               "Menu",
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 24,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.home),
        //         title: Text('Home'),
        //         onTap: () {
        //           // Handle navigation to home
        //           Navigator.pop(context); // close the drawer
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Settings'),
        //         onTap: () {
        //           // Handle navigation to settings
        //           Navigator.pop(context); // close the drawer
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.contact_mail),
        //         title: Text('Contact'),
        //         onTap: () {
        //           // Handle navigation to contact
        //           Navigator.pop(context); // close the drawer
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: items != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
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
