import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/task_card.dart';
import 'home_page.dart';
import 'inbox_page.dart';
import 'profile_page.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  // Pindah halaman sesuai tab yang ditekan
  void _onNavTap(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 2:
        page = const InboxPage();
        break;
      case 3:
        page = const ProfilePage();
        break;
      default:
        return; // sudah di Today
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F4EF),
        elevation: 0,
        title: const Text(
          'Today',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (index) => _onNavTap(context, index),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB7A6F5),
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        // LayoutBuilder untuk membaca lebar ruang yang tersedia
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Mobile: lebar penuh. Desktop/Web: batasi agar konten terpusat.
            double maxWidth =
                constraints.maxWidth >= 600 ? 480 : double.infinity;
            return Center(
              child: SizedBox(
                width: maxWidth,
                child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              const SizedBox(height: 20),

              // Search field
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEDE8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const TaskCard(
                title: 'Design Wireframe',
                time: 'Friday 08:00 AM - 09:00 AM',
                color: Color(0xFFE58E8E),
              ),
              const TaskCard(
                title: 'Meet with client',
                time: 'Friday 10:00 AM - 11:00 AM',
                color: Color(0xFF8EA5E5),
              ),
              const TaskCard(
                title: "April's content selection",
                description: "In april's content selection...",
                selected: true,
                leadingIcon: Icons.description_outlined,
              ),
              const TaskCard(
                title: 'Design Wireframe',
                time: 'Friday 08:00 AM - 09:00 AM',
                color: Color(0xFFE58E8E),
              ),
              const TaskCard(
                title: 'Meet with client',
                time: 'Friday 10:00 AM - 11:00 AM',
                color: Color(0xFF8EA5E5),
              ),
              const TaskCard(
                title: 'Brainstorming session - ideas',
                time: 'Saturday 08:00 AM - 17:00 PM',
                color: Color(0xFF8FD08F),
              ),

              const SizedBox(height: 80),
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
