import 'package:flutter_test/flutter_test.dart';
import 'package:layout_widget/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('readToken membaca token dari beberapa bentuk respons', () {
    expect(ApiService.readToken({'token': 'abc'}), 'abc');
    expect(ApiService.readToken({'access_token': 'def'}), 'def');
    expect(ApiService.readToken({'data': {'token': 'ghi'}}), 'ghi');
    expect(ApiService.readToken({'data': {'accessToken': 'jkl'}}), 'jkl');
  });

  test('readToken melempar Exception kalau token tidak ada', () {
    expect(() => ApiService.readToken({'message': 'nope'}), throwsException);
    expect(() => ApiService.readToken(null), throwsException);
    expect(() => ApiService.readToken({'token': ''}), throwsException);
  });

  test('jalur login/register: saveToken(readToken(res)) menyimpan token', () async {
    SharedPreferences.setMockInitialValues({});
    await ApiService.saveToken(ApiService.readToken({'data': {'token': 'tok-123'}}));
    expect(await ApiService.getToken(), 'tok-123');
  });
}
