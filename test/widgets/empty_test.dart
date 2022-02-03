import 'package:compras_app/src/core/widgets/empty_widget.dart';
import 'package:compras_app/src/data/datasource/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUpAll(() {
    GetIt.instance.registerSingleton<AppDatabase>(AppDatabase());
  });
  testWidgets('Test CustomEmptyWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      Localizations(
        delegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('en'),
        child: const CustomEmptyWidget(),
      ),
    );
    // Verify that our counter starts at 0.
    expect(find.text('No data'), findsOneWidget);
  });
}
