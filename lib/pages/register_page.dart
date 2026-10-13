import 'package:flutter/material.dart';
import '../service/api.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk membaca isi TextField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Status request register sedang berjalan
  bool _loading = false;

  // Controller dibersihkan saat halaman ditutup
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Mengirim data akun ke /auth/register lalu menyimpan token.
  Future<void> _register() async {
    // 1. Ambil teks dari TextField
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    // 2. Pastikan semua isian terisi
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage('Nama, email, dan password wajib diisi');
      return;
    }

    // 3. Kirim data ke server
    setState(() => _loading = true);
    try {
      final res = await ApiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      // 4. Simpan token supaya langsung masuk ke HomePage
      await ApiService.saveToken(ApiService.readToken(res));

      // 5. Berpindah ke HomePage dan hapus halaman register dari riwayat
      if (!mounted) return;
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    } catch (e) {
      // 6. Tampilkan pesan error dari server
      if (!mounted) return;
      _showMessage(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

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
                  'Your name',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Ralph Gilles',
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
                  'Your email address',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
                controller: passwordController,
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
                  onPressed: _loading ? null : _register,
                  icon: _loading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.arrow_forward, size: 16),
                  label: Text(_loading ? 'Loading...' : 'Register'),
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
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP0LqqItjj6kjPy2bhfx_Cs3kIqIEesiN8aMbEXoL-zw&s',
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
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv_-CwxoQcTdL_h0fGDNwtqfo9y18Fu7cE-p9pvCJ23w&s',
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
