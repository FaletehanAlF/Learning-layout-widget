import 'package:flutter/material.dart';
import '../service/api.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/task_card.dart';
import 'today_page.dart';
import 'inbox_page.dart';
import 'profile_page.dart';

// Halaman Home dengan BottomNavigationBar.
// Tab navigasi Home -> Today -> Inbox -> Profile.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data task yang diambil dari endpoint terlindungi GET /todos.
  List<Map<String, dynamic>> _todos = [];

  bool _loading = true;

  // Saat request gagal atau data kosong, tampilan kembali ke desain bawaan.
  bool _useFallback = true;

  static const List<Color> _taskColors = [
    Color(0xFFE58E8E),
    Color(0xFF8EA5E5),
    Color(0xFF8FD08F),
  ];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() => _loading = true);
    try {
      final res = await ApiService.get('/todos');
      final data = res is Map ? res['data'] : res;
      final items = data is List ? data.whereType<Map<String, dynamic>>().toList() : <Map<String, dynamic>>[];
      if (!mounted) return;
      setState(() {
        _todos = items;
        _useFallback = _todos.isEmpty;
      });
    } catch (e) {
      if (!mounted) return;
      debugPrint(e.toString().replaceFirst('Exception: ', ''));
      setState(() => _useFallback = true);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  // Mengambil nilai teks pertama yang tersedia dari beberapa nama field.
  String _pick(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
    }
    return '';
  }

  String _formatDate(String raw) {
    if (raw.isEmpty) return '';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return '${parsed.day} ${_monthName(parsed.month)} ${parsed.year}';
  }

  String _monthName(int month) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return names[month - 1];
  }

  Widget _buildTodoCard(Map<String, dynamic> todo, int index) {
    final title = _pick(todo, ['title', 'task', 'name', 'description']);
    final description = _pick(todo, ['description', 'notes', 'detail']);
    final due = _formatDate(_pick(todo, ['due_date', 'dueDate', 'date', 'deadline']));

    return TaskCard(
      title: title.isEmpty ? 'Untitled task' : title,
      time: due,
      description: due.isEmpty ? description : '',
      color: _taskColors[index % _taskColors.length],
    );
  }

  // Daftar task dari server, atau desain bawaan bila data tidak tersedia.
  Widget _buildTaskList() {
    if (_useFallback) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          TaskCard(
            title: 'Design Wireframe',
            time: 'Friday 08:00 AM - 09:00 AM',
            color: Color(0xFFE58E8E),
          ),
          TaskCard(
            title: 'Meet with client',
            time: 'Friday 10:00 AM - 11:00 AM',
            color: Color(0xFF8EA5E5),
          ),
          TaskCard(
            title: "April's content selection",
            description: "In april's content selection...",
            selected: true,
            leadingIcon: Icons.description_outlined,
          ),
          SizedBox(height: 8),
          TaskCard(
            title: 'Brainstorming session - ideas',
            time: 'Saturday 08:00 AM - 17:00 PM',
            color: Color(0xFF8FD08F),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Tasks (${_todos.length})',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 18),
            const Spacer(),
            if (_loading)
              const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(
          _todos.length,
          (index) => _buildTodoCard(_todos[index], index),
        ),
      ],
    );
  }

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
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F4EF),
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ),
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

              // Daftar task: dari API bila tersedia, jika tidak desain bawaan
              _buildTaskList(),

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
