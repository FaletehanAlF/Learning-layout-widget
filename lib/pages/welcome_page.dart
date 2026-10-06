import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF18243A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120),
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/66/e2/24/66e224c075720a95f01747f34b32be17.jpg',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),

            const Text(
              'Leafboard',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'A platform built for a new way of working',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 50,
              ),
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                ),
                label: const Text(
                  'Get Started For Free',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}