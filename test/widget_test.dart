import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waste_guard/main.dart';

void main() {
  testWidgets('WasteGuardPage navigates to RegisterPage on button press', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the WasteGuardPage is loaded.
    expect(find.text('WASTE GUARD'), findsOneWidget);

    // Find the ElevatedButton and tap it.
    final buttonFinder = find.byType(ElevatedButton);
    await tester.tap(buttonFinder);

    // Rebuild the widget tree after the state has changed.
    await tester.pumpAndSettle();

    // Verify that RegisterPage is displayed by checking for "REGISTER" text.
    expect(find.text('REGISTER'), findsOneWidget);
  });
}
