import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'home_page.dart';
import 'today_page.dart';
import 'profile_page.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  // Pindah halaman sesuai tab yang ditekan
  void _onNavTap(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const TodayPage();
        break;
      case 3:
        page = const ProfilePage();
        break;
      default:
        return; // sudah di Inbox
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EF),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 2,
        onTap: (index) => _onNavTap(context, index),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Baris atas: avatar kecil + icon notifikasi & chat
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFFEFF3D9),
                    child: const Text('FR', style: TextStyle(fontSize: 12)),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.notifications_none, size: 18),
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(Icons.chat_bubble_outline, size: 18),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Kartu aktivitas seperti pada desain
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xFFA99B5B),
                      child: const Icon(Icons.notifications, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Aktifitas Login baru',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Lorem Ipsum dolor is amet for a...',
                            style: TextStyle(fontSize: 12, color: Color(0xFFC9A25E)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
