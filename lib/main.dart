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
            width: 200,
            height: 150,
            color: Colors.amber,
          ),
          Positioned(
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.favorite_border),
            ),
          )
        ],
      )
    );
  }
}