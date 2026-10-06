import 'package:flutter/material.dart';

// Kartu task dipakai di Home dan Today.
// [title]   = judul task, contoh "Design Wireframe"
// [time]    = info waktu di bawah judul, contoh "Friday 08:00 AM - 09:00 AM"
// [color]   = warna lingkaran di kiri kartu
// [selected]= true untuk kartu yang sedang aktif (background ungu)
// [description] = teks pengganti waktu (untuk kartu yang aktif)
// [leadingIcon] = icon pengganti lingkaran warna
class TaskCard extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  final bool selected;
  final String description;
  final IconData? leadingIcon;

  const TaskCard({
    super.key,
    required this.title,
    this.time = '',
    this.color = Colors.grey,
    this.selected = false,
    this.description = '',
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE7E0FB) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian kiri: lingkaran warna atau icon
          if (leadingIcon != null)
            Icon(leadingIcon, size: 18, color: Colors.black87)
          else
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
            ),
          const SizedBox(width: 12),
          // Bagian tengah: judul dan waktu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  )
                else
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 12, color: Color(0xFFC9A25E)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          time,
                          style: const TextStyle(fontSize: 11, color: Color(0xFFC9A25E)),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.notifications_none, size: 12, color: Colors.grey),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
