import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_widget/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('debug login tap', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pump();
    final exc1 = tester.takeException();
    // ignore: avoid_print
    print('EXC after pumpWidget: $exc1');
    // ignore: avoid_print
    print('Continue finder: ${find.text("Continue").evaluate().length}');
    // ignore: avoid_print
    print('TextField count: ${find.byType(TextField).evaluate().length}');

    await tester.enterText(find.byType(TextField).at(0), 'salah@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'rahasia123');
    await tester.pump();
    final exc2 = tester.takeException();
    // ignore: avoid_print
    print('EXC after enterText: $exc2');

    // Cek tombol enabled atau tidak
    final btn = tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);
    // ignore: avoid_print
    print('BTN onPressed null? ${btn.onPressed == null}');

    await tester.tap(find.text('Continue'));
    await tester.pump(const Duration(milliseconds: 500));
    final exc3 = tester.takeException();
    // ignore: avoid_print
    print('EXC after tap+pump: $exc3');
    // ignore: avoid_print
    print('SnackBar? ${find.byType(SnackBar).evaluate().length}');
    await tester.pump(const Duration(seconds: 1));
    final exc4 = tester.takeException();
    // ignore: avoid_print
    print('EXC after extra pump: $exc4');
  });
}
