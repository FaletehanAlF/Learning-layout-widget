import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_widget/pages/home_page.dart';
import 'package:layout_widget/pages/inbox_page.dart';
import 'package:layout_widget/pages/login_page.dart';
import 'package:layout_widget/pages/profile_page.dart';
import 'package:layout_widget/pages/register_page.dart';
import 'package:layout_widget/pages/today_page.dart';

Future<void> cek(WidgetTester tester, String nama, Widget page, String teks) async {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(home: page));
  await tester.pumpAndSettle();
  debugPrint('$nama -> Y=${tester.getTopLeft(find.text(teks).first).dy}');
  expect(tester.takeException(), isNull, reason: nama);
}

void main() {
  testWidgets('semua halaman top-aligned dan tanpa overflow', (tester) async {
    await cek(tester, 'HOME', const HomePage(), 'Morning, Ralph');
    await cek(tester, 'TODAY', const TodayPage(), 'Search');
    await cek(tester, 'INBOX', const InboxPage(), 'Aktifitas Login baru');
    await cek(tester, 'PROFILE', const ProfilePage(), 'Alex Gilles');
    await cek(tester, 'LOGIN', const LoginPage(), 'Work without limits');
    await cek(tester, 'REGISTER', const RegisterPage(), 'Create your account');
  });

  testWidgets('halaman pendek tidak overflow', (tester) async {
    for (final p in <Widget>[const HomePage(), const TodayPage(), const InboxPage(), const ProfilePage(), const LoginPage(), const RegisterPage()]) {
      tester.view.physicalSize = const Size(360, 500);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(MaterialApp(home: p));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: '$p');
    }
  });
}
