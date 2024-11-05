import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MspChartsScreen extends StatefulWidget {
  const MspChartsScreen({super.key});

  @override
  State<MspChartsScreen> createState() => _MspChartsScreenState();
}

class _MspChartsScreenState extends State<MspChartsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {"title": "Linear (Ventas/Utilidades)", 'route': '/linear'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Microsip Charts'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
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
