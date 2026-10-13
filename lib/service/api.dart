import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Bisa di-override saat build: --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
  // Default localhost untuk Web/Desktop. Untuk emulator Android pakai 10.0.2.2,
  // untuk HP fisik pakai IP LAN laptop (mis. http://192.168.1.5:3000/api).
  static const String _baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );
  static const String _tokenKey = 'token';

  static const Duration _timeout = Duration(seconds: 15);

  // Client yang bisa disuntik dari test (MockClient) supaya tidak butuh server asli.
  static http.Client? _testClient;
  static void setTestClient(http.Client? client) => _testClient = client;

  static http.Client _client() => _testClient ?? http.Client();

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Mengambil token dari body respons server.
  // Mendukung {token: ...}, {access_token: ...}, maupun {data: {...}}.
  static String readToken(dynamic response) {
    for (final source in <dynamic>[response, if (response is Map) response['data']]) {
      if (source is! Map) continue;
      for (final key in const ['token', 'access_token', 'accessToken']) {
        final value = source[key];
        if (value is String && value.isNotEmpty) return value;
      }
    }
    throw Exception('Token tidak ditemukan pada respons server');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<Map<String, String>> _headers() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Token kosong dianggap belum login supaya tidak mengirim "Bearer ".
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static String _errorMessage(dynamic body) {
    if (body is Map) {
      final message = body['message'] ?? body['error'];
      if (message is String && message.isNotEmpty) return message;
      // Backend validasi sering mengembalikan List, mis. {message: ["Email..."]}.
      if (message is List && message.isNotEmpty) {
        return message.map((e) => e.toString()).join('\n');
      }
    }
    return 'Terjadi kesalahan';
  }

  static dynamic _handleResponse(http.Response response) {
    dynamic body;
    try {
      body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } on FormatException {
      // Server mengembalikan HTML/teks (mis. 404/500 proxy), bukan JSON.
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return null;
      }
      throw Exception(
        'Respons server tidak valid (${response.statusCode})',
      );
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }
    throw Exception(_errorMessage(body));
  }

  // Membungkus error jaringan (server mati, salah URL, timeout) jadi pesan
  // Indonesia yang mudah dipahami, bukan "SocketException ..." mentah.
  static Future<http.Response> _send(
    Future<http.Response> Function(http.Client client) call,
  ) async {
    final client = _client();
    final ownsClient = _testClient == null;
    try {
      return await call(client).timeout(
        _timeout,
        onTimeout: () => throw TimeoutException(
          'Server tidak merespons dalam ${_timeout.inSeconds} detik. '
          'Periksa backend di $_baseUrl.',
        ),
      );
    } on TimeoutException catch (e) {
      throw Exception(e.message ?? 'Request timeout');
    } on SocketException {
      throw Exception(
        'Tidak dapat terhubung ke server di $_baseUrl. '
        'Pastikan backend jalan dan URL benar '
        '(emulator Android pakai 10.0.2.2, bukan localhost).',
      );
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on http.ClientException catch (e) {
      throw Exception(e.message);
    } finally {
      if (ownsClient) client.close();
    }
  }

  static Future<dynamic> get(String endpoint) async {
    final headers = await _headers();
    final response = await _send(
      (client) => client.get(
        Uri.parse('$_baseUrl$endpoint'),
        headers: headers,
      ),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final headers = await _headers();
    final body = jsonEncode(data);
    final response = await _send(
      (client) => client.post(
        Uri.parse('$_baseUrl$endpoint'),
        headers: headers,
        body: body,
      ),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final headers = await _headers();
    final body = jsonEncode(data);
    final response = await _send(
      (client) => client.put(
        Uri.parse('$_baseUrl$endpoint'),
        headers: headers,
        body: body,
      ),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final headers = await _headers();
    final response = await _send(
      (client) => client.delete(
        Uri.parse('$_baseUrl$endpoint'),
        headers: headers,
      ),
    );
    return _handleResponse(response);
  }
}