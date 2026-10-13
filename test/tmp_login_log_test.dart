// Test: memastikan pesan login tampil di terminal/console dan alur login benar.
// Memakai MockClient (tanpa socket/server asli) supaya stabil di flutter test.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:layout_widget/pages/home_page.dart';
import 'package:layout_widget/pages/login_page.dart';
import 'package:layout_widget/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> _logs = <String>[];

void main() {
  late void Function(String?, {int? wrapWidth}) originalDebugPrint;

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    ApiService.setTestClient(null);
    _logs.clear();
    originalDebugPrint = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) _logs.add(message);
    };
  });

  tearDown(() {
    debugPrint = originalDebugPrint;
    ApiService.setTestClient(null);
  });

  Future<void> isiDanTapLogin(
    WidgetTester tester,
    String email, {
    required MockClient client,
  }) async {
    ApiService.setTestClient(client);
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), email);
    await tester.enterText(find.byType(TextField).at(1), 'rahasia123');
    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
  }

  testWidgets('login gagal: error muncul di terminal dan SnackBar', (
    tester,
  ) async {
    final client = MockClient((request) async {
      if (request.url.path.endsWith('/auth/login')) {
        return http.Response(
          jsonEncode(<String, dynamic>{
            'message': 'Email atau password salah',
          }),
          401,
          headers: {'Content-Type': 'application/json'},
        );
      }
      return http.Response('[]', 200);
    });

    await isiDanTapLogin(tester, 'salah@example.com', client: client);

    expect(
      _logs.any((l) => l.contains('[LOGIN] Gagal untuk salah@example.com')),
      isTrue,
      reason: 'terminal logs: $_logs',
    );
    expect(_logs.any((l) => l.contains('Email atau password salah')), isTrue,
        reason: 'terminal logs: $_logs');
    expect(find.text('Email atau password salah'), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
    expect(await ApiService.getToken(), isNull);
  });

  testWidgets('login berhasil: sukses muncul di terminal dan pindah HomePage', (
    tester,
  ) async {
    final client = MockClient((request) async {
      if (request.url.path.endsWith('/auth/login')) {
        return http.Response(
          jsonEncode(<String, dynamic>{'token': 'tok-123'}),
          200,
          headers: {'Content-Type': 'application/json'},
        );
      }
      if (request.url.path.endsWith('/todos')) {
        return http.Response('[]', 200);
      }
      return http.Response('{}', 200);
    });

    await isiDanTapLogin(tester, 'benar@example.com', client: client);

    expect(
      _logs.any((l) => l.contains('[LOGIN] Berhasil: benar@example.com')),
      isTrue,
      reason: 'terminal logs: $_logs',
    );
    expect(find.byType(HomePage), findsOneWidget);
    expect(await ApiService.getToken(), 'tok-123');
  });
}
