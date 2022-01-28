import 'package:compras_app/src/core/widgets/empty_widget.dart';
import 'package:compras_app/src/core/widgets/error_widget.dart';
import 'package:compras_app/src/core/widgets/loading_widget.dart';
import 'package:compras_app/src/data/models/item_model.dart';
import 'package:compras_app/src/presentations/detail/widgets/items_list.dart';
import 'package:compras_app/src/presentations/home/widgets/new_list_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Test LoadingWidget', (WidgetTester tester) async {
    await tester.pumpWidget(const LoadingWidget());

    // Verify that our counter starts at 0.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Test CustomEmptyWidget', (WidgetTester tester) async {
    await tester.pumpWidget(Localizations(
      delegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
      child: const CustomEmptyWidget(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text("No data"), findsOneWidget);
  });

  testWidgets('Test CustomErrorWidget', (WidgetTester tester) async {
    await tester.pumpWidget(Localizations(
      delegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
      child: const CustomErrorWidget(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text("An error has ocurred"), findsOneWidget);
  });

  testWidgets('Test NewListButton', (WidgetTester tester) async {
    await tester.pumpWidget(Localizations(
      delegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
      child: const NewListButton(),
    ));

    // Verify that our counter starts at 0.
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Test ItemsList', (WidgetTester tester) async {
    await tester.pumpWidget(Localizations(
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
                  isChecked: true)
            ],
          ),
        ),
      ),
    ));

    // Verify that our counter starts at 0.
    expect(find.byType(Card), findsOneWidget);
  });
}
