import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Menyimpan status password terlihat atau tidak
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  'Work without limits',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),

                const SizedBox(height: 50),

                // Label email
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
                      borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Label password
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose a password',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'min. 8 characters',
                    hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      // Tukar status terlihat/tidaknya password
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Tombol Continue, navigasi ke HomePage
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
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text('Continue'),
                  ),
                ),

                const SizedBox(height: 24),

                // Pemisah "or"
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('or', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

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
                    icon: const Icon(Icons.g_mobiledata, size: 24, color: Colors.black87),
                    label: const Text('Sign up with Google', style: TextStyle(color: Colors.black87)),
                  ),
                ),

                const SizedBox(height: 12),

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
                    icon: const Icon(Icons.apple, size: 20, color: Colors.black87),
                    label: const Text('Sign up with Apple', style: TextStyle(color: Colors.black87)),
                  ),
                ),

                const SizedBox(height: 12),

                // Link ke halaman Register
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
