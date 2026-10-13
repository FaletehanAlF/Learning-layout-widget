import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_widget/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late HttpServer _server;
late int _stubPort;
late HttpClient _realClient;

class _StubHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    // ignore: avoid_print
    print('STUB openUrl: $method $url');
    final isApi = url.port == 3000;
    final target = isApi
        ? url.replace(scheme: 'http', host: '127.0.0.1', port: _stubPort)
        : url.replace(scheme: 'http', host: '127.0.0.1', port: _stubPort, path: '/__image');
    return _realClient.openUrl(method, target);
  }
  @override
  Future<HttpClientRequest> getUrl(Uri url) => openUrl('GET', url);
  @override
  void close({bool force = false}) {}
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
    res.add(<int>[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
  } else {
    res.headers.contentType = ContentType.json;
    res.statusCode = 401;
    res.write(jsonEncode(<String, dynamic>{'message': 'Email atau password salah'}));
  }
  await res.close();
}

void main() {
  setUpAll(() async {
    HttpOverrides.global = null;
    _realClient = HttpClient();
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _stubPort = _server.port;
    _server.listen(_handle);
    // ignore: avoid_print
    print('STUB PORT: $_stubPort');
  });
  tearDownAll(() async {
    await _server.close(force: true);
    _realClient.close(force: true);
  });

  testWidgets('debug stub', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await HttpOverrides.runZoned(() async {
      tester.view.physicalSize = const Size(1200, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.pump();
      tester.takeException();
      // ignore: avoid_print
      print('pumped, Continue count=${find.text("Continue").evaluate().length}');
      await tester.enterText(find.byType(TextField).at(0), 'salah@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'rahasia123');
      await tester.tap(find.text('Continue'));
      await tester.pump(const Duration(milliseconds: 500));
      tester.takeException();
      // ignore: avoid_print
      print('tapped, waiting...');
      await tester.runAsync(() async {
        await Future<void>.delayed(const Duration(milliseconds: 700));
      });
      await tester.pump();
      final e = tester.takeException();
      // ignore: avoid_print
      print('EXC after wait: $e');
      // ignore: avoid_print
      print('SnackBar count=${find.byType(SnackBar).evaluate().length}');
      // ignore: avoid_print
      print('SnackBar text finder=${find.text("Email atau password salah").evaluate().length}');
    }, createHttpClient: (_) => _StubHttpClient());
  });
}
