import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/task_card.dart';
import 'today_page.dart';
import 'inbox_page.dart';
import 'profile_page.dart';

// Halaman Home dengan BottomNavigationBar.
// Tab navigasi Home -> Today -> Inbox -> Profile.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Pindah halaman sesuai tab yang ditekan
  void _onNavTap(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 1:
        page = const TodayPage();
        break;
      case 2:
        page = const InboxPage();
        break;
      case 3:
        page = const ProfilePage();
        break;
      default:
        return; // sudah di Home
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
        currentIndex: 0,
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
                        // Titik merah kecil penanda notifikasi baru
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

              const Text(
                'Morning, Ralph',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              const Text(
                'April 27, 2026',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

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

              const SizedBox(height: 24),

              // Judul section Today
              const Row(
                children: [
                  Text('Today (3)', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),

              const SizedBox(height: 12),

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

              const SizedBox(height: 8),

              // Judul section 30 Apr
              const Row(
                children: [
                  Text('30 Apr (1)', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),

              const SizedBox(height: 12),

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
