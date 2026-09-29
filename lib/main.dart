import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

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

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            color: Colors.amber,
            height: 100,
          ),
          Container(
            color: Colors.red,
            height: 100,
          ),
          Container(
            color: Colors.purple,
            height: 100,
          ),
          Container(
            color: Colors.blue,
            height: 100,
          ),
          Container(
            color: Colors.green,
            height: 100,
          ),
          Container(
            color: Colors.cyan,
            height: 100,
          ),
          Container(
            color: Colors.orange,
            height: 100,
          )
        ],
      )
    );
  }
}

