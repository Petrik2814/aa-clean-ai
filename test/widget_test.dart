import 'package:aaclean_ai/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AA CLEAN AI sa spustí', (WidgetTester tester) async {
    await tester.pumpWidget(const AACleanAI());
    expect(find.text('AA CLEAN AI'), findsOneWidget);
  });
}
