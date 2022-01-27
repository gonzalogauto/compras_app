import 'package:compras_app/src/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test LoadingWidget', (WidgetTester tester) async {
    await tester.pumpWidget(const LoadingWidget());

    // Verify that our counter starts at 0.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
