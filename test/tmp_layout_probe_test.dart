import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_widget/pages/inbox_page.dart';
import 'package:layout_widget/pages/welcome_page.dart';

void main() {
  testWidgets('cek posisi konten inbox (harus di atas)', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: InboxPage()));
    await tester.pumpAndSettle();
    final text = find.text('Aktifitas Login baru');
    debugPrint('POSISI Y KARTU INBOX: ${tester.getTopLeft(text).dy}');
  });

  testWidgets('welcome page tidak overflow di layar pendek', (tester) async {
    tester.view.physicalSize = const Size(400, 420);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: WelcomePage()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    debugPrint('TOMBOL Y: ${tester.getTopLeft(find.text('Get Started for Free')).dy}');
  });

  testWidgets('welcome page tombol di bawah pada layar normal', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: WelcomePage()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    debugPrint('TOMBOL Y NORMAL: ${tester.getTopLeft(find.text('Get Started for Free')).dy}');
  });
}
