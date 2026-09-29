import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.amber,
            width: 100,
            height: 200,
          ),
          Container(
            color: const Color.fromARGB(255, 255, 7, 7),
            width: 100,
            height: 200,
          ),
          Container(
            color: const Color.fromARGB(255, 61, 7, 255),
            width: 100,
            height: ,
          )
        ],

      ),
    );
  }
}