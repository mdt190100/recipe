import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Recipe>> fetchRecipes(String ingredient) async {
  final apiKey =
      'dbd93e15b0024f608da7026f51534cb0'; // Thay thế bằng API key của bạn
  final appId = '553a4212'; // Thay thế bằng App ID của bạn
  final url =
      'https://api.edamam.com/api/recipes/v2?type=public&q=$ingredient&app_id=$appId&app_key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<Recipe> recipes = [];
    for (var item in data['hits']) {
      recipes.add(Recipe.fromJson(item['recipe']));
    }
    return recipes;
  } else {
    throw Exception('Failed to load recipes');
  }
}

class Recipe {
  final String label;
  final String image;
  final String url;

  Recipe({required this.label, required this.image, required this.url});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      label: json['label'],
      image: json['image'],
      url: json['url'],
    );
  }
}
