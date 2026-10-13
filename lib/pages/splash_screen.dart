import 'package:flutter/material.dart';

/// Splash screen sederhana: logo + loading, dipakai saat aplikasi dibuka.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1C2340),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.eco, size: 64, color: Color(0xFF58CC5A)),
              SizedBox(height: 16),
              Text(
                'Leafboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFB7F36E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
