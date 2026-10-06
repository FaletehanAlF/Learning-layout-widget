import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final data = const [
    'Next.js',
    'Flutter',
    'Express',
    'React',
    'Laravel',
    'Dart',
    'JavaScript',
    'TypeScript',
    'Python',
    'PHP',
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Teknologi"),
      ),
      body: Stack(
        children: [
          Container(
            width: 400,
            height: 400,
            color: Colors.amber,
            child: Image.network("https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcSKAVbf6D-HIPh9avrdm3d2cO-MUeJcRHnI_WhpryaAri1l97vC28S2FcUo8j1tz0T9PcnKOGAAaV192ZgwGqfyYH3-HHfhGVT-EkpJrneNZLnDxamsEaFHJa9ONSUXkJgDIh5x0S5G&s=19"),
          ),
          Positioned(
            top: 10,
            right: 10,
            left: 10,
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.favorite_border),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Chip(label: Text("New")),
          )
        ],
      )
    );
  }
}