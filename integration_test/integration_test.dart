import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rpn_calculator/main.dart' as my_app_main;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Calculator Integration Tests', () {
    testWidgets('Should perform basic operations and update the display', (WidgetTester tester) async {
      my_app_main.main();
      await tester.pumpAndSettle();

      // Simulate button taps for numbers and operations.
      await tester.tap(find.text('3'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('*'));
      await tester.pumpAndSettle();

      // Verify the result is displayed. This assumes that the display updates as expected.
      expect(find.text('12.0'), findsOneWidget);
    });
  });
}
