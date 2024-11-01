import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GraphicScreen extends StatelessWidget {
  const GraphicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      // {"title": "Lineal", 'route': '/graphic-linel'},
      {"title": "Circular", 'route': '/graphic-circular'},
      {"title": "Bar", 'route': '/graphic-bar'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text("Graphic",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]['title']!),
            onTap: () => {context.push(data[index]['route'].toString())},
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}
