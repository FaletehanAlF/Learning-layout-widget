import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth =
                constraints.maxWidth >= 600 ? 480 : double.infinity;
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: maxWidth,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
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

                          SizedBox(
                            height: 48,
                            child: Transform.translate(
                              offset: const Offset(0, -48),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: const Icon(
                                  Icons.eco,
                                  size: 64,
                                  color: Color(0xFF58CC5A),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

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
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ),

                          const Spacer(),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: SizedBox(
                              height: 44,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB7F36E),
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
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
