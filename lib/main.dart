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

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late Future<String?> _tokenFuture;

  @override
  void initState() {
    super.initState();
    _tokenFuture = _readToken();
  }

  Future<String?> _readToken() async {
    try {
      return await ApiService.getToken();
    } catch (e) {
      debugPrint('Gagal membaca token: $e');
      return null;
    }
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
          debugPrint('Gagal membaca token: ${snapshot.error}');
        }
        final token = snapshot.data;
        final loggedIn = token != null && token.isNotEmpty;
        return loggedIn ? const HomePage() : const WelcomePage();
      },
    );
  }
}
