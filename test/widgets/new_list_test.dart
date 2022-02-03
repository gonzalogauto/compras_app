import 'package:compras_app/src/data/datasource/database/database.dart';
import 'package:compras_app/src/presentations/home/widgets/new_list_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUpAll(() {
    GetIt.instance.registerSingleton<AppDatabase>(AppDatabase());
  });
  testWidgets('Test NewListButton', (WidgetTester tester) async {
    await tester.pumpWidget(
      Localizations(
        delegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('en'),
        child: const NewListButton(),
      ),
    );
    // Verify that our counter starts at 0.
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
