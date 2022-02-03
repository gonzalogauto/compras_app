import 'package:compras_app/src/core/widgets/loading_widget.dart';
import 'package:compras_app/src/data/datasource/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUpAll(() {
    GetIt.instance.registerSingleton<AppDatabase>(AppDatabase());
  });
  testWidgets('Test LoadingWidget', (WidgetTester tester) async {
    await tester.pumpWidget(const LoadingWidget());
    // Verify that our counter starts at 0.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
