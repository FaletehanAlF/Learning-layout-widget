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
            // Area navy di bagian atas, bagian bawahnya melengkung.
            // Avatar diletakkan menimpa lengkungan navy dengan Stack.
            Container(
              height: 280,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1C2340),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(130),
                  bottomRight: Radius.circular(130),
                ),
              ),
            ),

            // Avatar naik ke atas agar menimpa lengkungan navy
            SizedBox(
              height: 48,
              child: Transform.translate(
                offset: const Offset(0, -48),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: const NetworkImage(
                    'https://i.pinimg.com/736x/66/e2/24/66e224c075720a95f01747f34b32be17.jpg',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Leafboard',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'A platform built for a new way of working',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),

            const Spacer(),

            // Tombol hijau berbentuk pil, navigasi ke LoginPage
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB7F36E),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text(
                    'Get Started for Free',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
