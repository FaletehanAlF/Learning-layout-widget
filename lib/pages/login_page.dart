import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 50),

              Row(
                mainAxisAligment: MainAxisAlignment.center,
                children: [
                 icon(
                  icons.eco,
                  size: 50,
                  colors: Colors.green,
                 ),
                 const SizedBox(width: 5,).
                 const Text(
                  'Leafboard',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                  ),
                 ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                'A platform built for a new way of working',
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 55),

              const align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Email Address',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                decoration: InputDecoration(
                  hintText: 'user123@example.com',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBDBDBD),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),


            ]
          )
        )
      )
    );
  }
}