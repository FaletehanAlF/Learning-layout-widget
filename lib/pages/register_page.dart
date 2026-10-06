import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Mobile: lebar penuh. Desktop/Web: form dibatasi lebarnya.
            double maxWidth =
                constraints.maxWidth >= 600 ? 480 : double.infinity;
            return Center(
              child: SizedBox(
                width: maxWidth,
                child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Logo Leafboard
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1C2340),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.eco, size: 14, color: Color(0xFFB7F36E)),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Leafboard',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              const Text(
                'Create your account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your email address',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'email@gmail.com',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose a password',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'min. 8 characters',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  suffixIcon: const Icon(Icons.visibility_off_outlined, size: 18, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Register, tanpa validasi cukup navigasi ke HomePage
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB7F36E),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Register'),
                ),
              ),

              const SizedBox(height: 20),

              // Link kembali ke halaman login
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
              ),
            );
          },
        ),
      ),
    );
  }
}
