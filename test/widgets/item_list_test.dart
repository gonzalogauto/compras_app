import 'package:compras_app/src/data/datasource/database/database.dart';
import 'package:compras_app/src/data/models/item_model.dart';
import 'package:compras_app/src/presentations/detail/widgets/items_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUpAll(() {
    GetIt.instance.registerSingleton<AppDatabase>(AppDatabase());
  });
  testWidgets('Test ItemsList', (WidgetTester tester) async {
    await tester.pumpWidget(
      Localizations(
        delegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('en'),
        child: MaterialApp(
          home: Scaffold(
            body: ItemsList(
              items: [
                ItemModel(
                  id: 1,
                  description: 'test',
                  quantity: 1,
                  unitPrice: 123,
                  isChecked: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // Verify that our counter starts at 0.
    expect(find.byType(Card), findsOneWidget);
  });
}
