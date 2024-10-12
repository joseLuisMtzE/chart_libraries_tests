import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlChartsScreen extends StatelessWidget {
  const FlChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {"title": "Lineal", 'route': '/fl-lineal'},
      {"title": "Circular", 'route': '/fl-circular'},
      {"title": "Bars", 'route': '/fl-bars'},
      {"title": "Custom Lineal", 'route': '/custom-lineal'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text("FL Charts",
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
