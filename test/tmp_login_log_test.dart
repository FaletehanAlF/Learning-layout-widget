// Test sementara: memastikan pesan login tampil di terminal/console.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_widget/pages/home_page.dart';
import 'package:layout_widget/pages/login_page.dart';
import 'package:layout_widget/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

late HttpServer _server;
late int _stubPort;
final List<String> _logs = <String>[];

// PNG 1x1 transparan, supaya Image.network di halaman login tidak error.
final List<int> _png = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0D, 0x49, 0x44, 0x41, 0x54, 0x08, 0xD7, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
];

// Client asli (socket), dibuat sebelum override dipasang supaya tidak rekursi.
late HttpClient _realClient;

/// Mengarahkan semua request (termasuk gambar) ke server tiruan di test ini.
class _StubHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    final isApi = url.port == 3000;
    final target = isApi
        ? url.replace(scheme: 'http', host: '127.0.0.1', port: _stubPort)
        : url.replace(
            scheme: 'http',
            host: '127.0.0.1',
            port: _stubPort,
            path: '/__image',
          );
    return _realClient.openUrl(method, target);
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) => openUrl('GET', url);

  // Package http menutup client setelah tiap request; client di sini dipakai
  // bersama, jadi penutupan diabaikan.
  @override
  void close({bool force = false}) {}

  // Anggota lain yang dipakai Flutter (mis. autoUncompress) cukup di-no-op.
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

Future<void> _handle(HttpRequest req) async {
  final body = await utf8.decoder.bind(req).join();
  // ignore: avoid_print
  print('STUB HIT: ${req.method} ${req.uri.path} body=$body');
  final res = req.response;
  if (req.uri.path.startsWith('/__image')) {
    res.headers.contentType = ContentType('image', 'png');
    res.add(_png);
  } else if (req.uri.path.endsWith('/todos')) {
    res.headers.contentType = ContentType.json;
    res.write(jsonEncode(<dynamic>[]));
  } else if (body.contains('benar@example.com')) {
    res.headers.contentType = ContentType.json;
    res.write(jsonEncode(<String, dynamic>{'token': 'tok-123'}));
  } else {
    res.statusCode = 401;
    res.headers.contentType = ContentType.json;
    res.write(
      jsonEncode(<String, dynamic>{'message': 'Email atau password salah'}),
    );
  }
  await res.close();
}

void main() {
  late void Function(String?, {int? wrapWidth}) originalDebugPrint;

  setUpAll(() async {
    // flutter_test memblokir network; matikan dulu supaya HttpClient() di sini
    // benar-benar client socket asli (bukan mock), lalu dipakai server tiruan.
    HttpOverrides.global = null;
    _realClient = HttpClient();

    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _stubPort = _server.port;
    _server.listen(_handle);
  });

  tearDownAll(() async {
    await _server.close(force: true);
    _realClient.close(force: true);
    debugPrint = originalDebugPrint;
  });

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    _logs.clear();
    originalDebugPrint = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) _logs.add(message);
    };
    addTearDown(() {
      // ignore: avoid_print
      print('CAPTURED LOGS: ${_logs.length} -> $_logs');
    });
    debugPrint('PROBE: capture aktif');
  });

  /// Menunggu request HTTP nyata selesai, lalu memproses frame hasilnya.
  Future<void> selesaikanRequest(WidgetTester tester) async {
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 700));
    });
    await tester.pump();
    tester.takeException();
  }

  Future<void> isiDanTapLogin(WidgetTester tester, String email) async {
    // Layar diperbesar supaya halaman login tidak overflow di viewport test.
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pump();
    tester.takeException();
    await tester.enterText(find.byType(TextField).at(0), email);
    await tester.enterText(find.byType(TextField).at(1), 'rahasia123');
    await tester.tap(find.text('Continue'));
    // Majukan clock: arena gesture selesai -> _login() jalan & request terkirim.
    await tester.pump(const Duration(milliseconds: 500));
    await selesaikanRequest(tester);
  }

  testWidgets('login gagal: error muncul di terminal dan SnackBar', (
    tester,
  ) async {
    await HttpOverrides.runZoned(() async {
      await isiDanTapLogin(tester, 'salah@example.com');

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

      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      tester.takeException();
    }, createHttpClient: (_) => _StubHttpClient());
  });

  testWidgets('login berhasil: sukses muncul di terminal dan pindah HomePage', (
    tester,
  ) async {
    await HttpOverrides.runZoned(() async {
      await isiDanTapLogin(tester, 'benar@example.com');

      expect(
        _logs.any((l) => l.contains('[LOGIN] Berhasil: benar@example.com')),
        isTrue,
        reason: 'terminal logs: $_logs',
      );
      expect(find.byType(HomePage), findsOneWidget);
      expect(await ApiService.getToken(), 'tok-123');

      await tester.pump(const Duration(seconds: 5));
      tester.takeException();
    }, createHttpClient: (_) => _StubHttpClient());
  });
}
