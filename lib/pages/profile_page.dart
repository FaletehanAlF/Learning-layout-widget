import 'package:flutter/material.dart';
import '../service/api.dart';
import '../widgets/bottom_nav.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'today_page.dart';
import 'inbox_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> _profile = {};

  bool _loading = true;

  static const String _fallbackName = 'Alex Gilles';
  static const String _fallbackPhone = '+7 904 599 XXX 11';
  static const String _fallbackEmail = 'alex@gmail.com';
  static const String _fallbackAddress = 'St. Petersburg, Vos...';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);
    try {
      dynamic res;
      Object? lastError;
      for (final endpoint in const ['/auth/profile', '/profile', '/auth/me']) {
        try {
          res = await ApiService.get(endpoint);
          lastError = null;
          break;
        } catch (e) {
          lastError = e;
        }
      }
      if (lastError != null) throw lastError;
      final data = res is Map ? res['data'] : res;
      if (!mounted) return;
      setState(() {
        _profile =
            data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{};
      });
    } catch (e) {
      if (!mounted) return;
      debugPrint(
        '[PROFILE] Gagal memuat profil: ${e.toString().replaceFirst('Exception: ', '')}',
      );
      setState(() => _profile = {});
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String _value(List<String> keys, String fallback) {
    for (final key in keys) {
      final value = _profile[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
      if (value is num) {
        return value.toString();
      }
    }
    return fallback;
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah kamu yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    await ApiService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _onNavTap(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const TodayPage();
        break;
      case 2:
        page = const InboxPage();
        break;
      default:
        return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F4EF),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.black87, size: 20),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (index) => _onNavTap(context, index),
      ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: [
                          const _ProfileAvatar(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, size: 14),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Text(
                        _value(['name', 'username', 'full_name'], _fallbackName),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      if (_loading) ...[
                        const SizedBox(height: 12),
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ],

                      const SizedBox(height: 28),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            _infoRow(
                              Icons.phone_outlined,
                              'PHONE',
                              _value(
                                ['phone', 'phone_number', 'telp'],
                                _fallbackPhone,
                              ),
                            ),
                            const Divider(),
                            _infoRow(
                              Icons.email_outlined,
                              'EMAIL',
                              _value(['email'], _fallbackEmail),
                            ),
                            const Divider(),
                            _infoRow(
                              Icons.location_on_outlined,
                              'ADDRESS',
                              _value(['address', 'city'], _fallbackAddress),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            side: const BorderSide(color: Color(0xFFE3E3E3)),
                          ),
                          onPressed: _logout,
                          icon: const Icon(Icons.logout, size: 16),
                          label: const Text('Logout'),
                        ),
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

class _ProfileAvatar extends StatefulWidget {
  const _ProfileAvatar();

  @override
  State<_ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<_ProfileAvatar> {
  static const String _imageUrl =
      'https://i.pinimg.com/736x/66/e2/24/66e224c075720a95f01747f34b32be17.jpg';

  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: const Color(0xFFE7E0FB),
      backgroundImage: _hasError ? null : const NetworkImage(_imageUrl),
      onBackgroundImageError: _hasError
          ? null
          : (Object error, StackTrace? stackTrace) {
              if (!mounted) return;
              setState(() => _hasError = true);
            },
      child: _hasError
          ? const Icon(Icons.person, size: 40, color: Colors.grey)
          : null,
    );
  }
}
