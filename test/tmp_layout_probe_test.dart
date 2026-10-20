import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_widget/pages/inbox_page.dart';

void main() {
  testWidgets('cek posisi konten inbox', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: InboxPage()));
    await tester.pumpAndSettle();
    final text = find.text('Aktifitas Login baru');
    print('POSISI Y KARTU: ${tester.getTopLeft(text).dy}');
  });
}
