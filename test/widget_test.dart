import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latihanquiz_124230062/main.dart';

void main() {
  testWidgets('Login berhasil dan tampil Selamat datang, Merry 👋',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(); // tunggu frame awal & FutureBuilder

    // Pastikan form login tampil
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Isi username & password menggunakan Key (lebih stabil)
    await tester.enterText(find.byKey(const Key('username_field')), 'Merry');
    await tester.enterText(find.byKey(const Key('password_field')), 'Theogives');

    // Tap tombol login
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle(); // tunggu navigasi selesai

    // Pastikan masuk ke HomePage dengan teks persis
    expect(find.text('Selamat datang, Merry 👋'), findsOneWidget);
  });

  testWidgets('Login gagal jika password salah', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('username_field')), 'Merry');
    await tester.enterText(find.byKey(const Key('password_field')), 'SalahPass');

    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pump(const Duration(milliseconds: 500)); // beri waktu snackbar muncul

    expect(find.text('Login gagal, username atau password salah!'), findsOneWidget);
  });
}
