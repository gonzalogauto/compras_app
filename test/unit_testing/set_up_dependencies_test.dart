import 'package:compras_app/src/core/locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('setUpDependencies test', () async {
    await setUpDependencies();
    expect(locator, isNot(null));
  });
}
