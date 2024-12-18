import 'package:flutter/material.dart';
import 'recipe_api.dart'; // Đảm bảo bạn đã tạo file recipe_api.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 142, 201, 164)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Recipe Finder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Recipe> _recipes = [];

  void _searchRecipes() {
    if (_controller.text.isNotEmpty) {
      fetchRecipes(_controller.text).then((recipes) {
        setState(() {
          _recipes = recipes;
        });
      }).catchError((e) {
        // Xử lý lỗi nếu cần
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Recipe Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter ingredient'),
            ),
            ElevatedButton(
              onPressed: _searchRecipes,
              child: const Text('Search Recipes'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return ListTile(
                    title: Text(recipe.label),
                    leading: Image.network(recipe.image),
                    onTap: () {
                      // Chuyển đến trang chi tiết công thức (chưa thực hiện ở đây)
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
