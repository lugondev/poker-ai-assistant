import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:poker_ai_calculator/main.dart';

void main() {
  testWidgets('App renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PokerAiApp()));

    expect(find.text('POKER AI'), findsOneWidget);
  });
}
