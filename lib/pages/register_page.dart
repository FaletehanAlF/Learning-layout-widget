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
                  // Logo leaf hijau di kiri teks Leafboard
                  const Icon(Icons.eco, size: 26, color: Color(0xFF58CC5A)),
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

              // Pemisah "or"
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 24),

              // Tombol Google
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    side: const BorderSide(color: Color(0xFFE3E3E3)),
                  ),
                  onPressed: () {},
                  icon: Image.network(
                    'https://yt3.googleusercontent.com/bAseQlKvNmjdLQrvYWm_q3QDp8C8YKyYI-nYJewgOkPi0JU1_3X9oFgjrEdzkOlXzLGFxFbnsw=s900-c-k-c0x00ffffff-no-rj',
                    width: 20,
                    height: 20,
                  ),
                  label: const Text('Sign up with Google', style: TextStyle(color: Colors.black87)),
                ),
              ),

              const SizedBox(height: 12),

              // Tombol Apple
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    side: const BorderSide(color: Color(0xFFE3E3E3)),
                  ),
                  onPressed: () {},
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/0/747.png',
                    width: 20,
                    height: 20,
                  ),
                  label: const Text('Sign up with Apple', style: TextStyle(color: Colors.black87)),
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
