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
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20),
        reverse: true,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            height: 100,
            color: Colors.amber,
            child: Center(
              child: Text(
                widget.data[index],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }
}