import 'package:flutter_test/flutter_test.dart';
import 'package:interval_timer/main.dart';

void main() {
  testWidgets('App shell shows the app title', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Interval Timer'), findsOneWidget);
  });
}
