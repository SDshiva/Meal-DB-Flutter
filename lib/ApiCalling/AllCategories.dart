// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void fetchItems() async {
//   final response = await http
//       .get(Uri.parse('www.themealdb.com/api/json/v1/1/categories.php'));

//   if (response.statusCode == 200) {
//     // Parse the JSON response
//     // Map<String, dynamic> jsonResponse = json.decode(response.body);
//     // return Items.fromJson(jsonResponse);
//     final jsonResponse = jsonDecode(response.body);

//     return jsonResponse;
//   } else {
//     throw Exception('Failed to load items');
//   }
// }
