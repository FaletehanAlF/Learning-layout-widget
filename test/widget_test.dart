import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:layout_widget/main.dart';

void main() {
  testWidgets('MyApp menampilkan AuthGate lalu WelcomePage saat belum login',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    await tester.pumpWidget(const MyApp());

    // Saat token dibaca, tampil loading dulu.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    // Belum ada token -> WelcomePage dengan tombol Get Started.
    expect(find.text('Leafboard'), findsWidgets);
    expect(find.text('Get Started for Free'), findsOneWidget);
  });

  testWidgets('MyApp langsung ke HomePage saat token tersimpan',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'token': 'tok-123',
    });

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });
}
