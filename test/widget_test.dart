import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hmti_management_system_v2/app.dart';
import 'package:hmti_management_system_v2/config/dependencies.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Splash lalu Login tampil dengan input dan tombol login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(providers: globalProviders, child: const MyApp()),
    );

    expect(find.text('HMTI MANAGEMENT SYSTEM'), findsOneWidget);

    // Contoh kalau splash punya delay / animasi:
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Cek widget yang benar-benar ada di LoginScreen, misalnya:
    expect(find.byType(TextField), findsAtLeastNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    // Untuk mencocokkan teks tombol LOGIN
    expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);
  });
}
