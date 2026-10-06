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

              // Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.eco,
                    size: 20,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Leafboard',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Work without limits',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 55),

              // Email
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your email address',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                decoration: InputDecoration(
                  hintText: 'email@gmail.com',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose a password',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'min. 8 characters',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.visibility_off_outlined,
                    size: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Continue
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 16,
                  ),
                  label: const Text('Continue'),
                ),
              ),

              const SizedBox(height: 20),

              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              // Google
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.g_mobiledata,
                    size: 24,
                  ),
                  label: const Text('Sign up with Google'),
                ),
              ),

              const SizedBox(height: 12),

              // Apple
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.apple,
                    size: 20,
                  ),
                  label: const Text('Sign up with Apple'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}