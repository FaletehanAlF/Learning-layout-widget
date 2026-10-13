import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/welcome_page.dart';
import 'service/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leafboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

// Menentukan halaman awal aplikasi berdasarkan token yang tersimpan.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final Future<String?> _tokenFuture;

  @override
  void initState() {
    super.initState();
    _tokenFuture = ApiService.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _tokenFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Gagal memeriksa sesi pengguna'),
            ),
          );
        }
        return snapshot.data != null ? const HomePage() : const WelcomePage();
      },
    );
  }
}