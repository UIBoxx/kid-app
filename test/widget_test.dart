import 'package:flutter_test/flutter_test.dart';
import 'package:kidzworld/pages/homepage.dart';
import 'package:kidzworld/main.dart';

void main() {
  testWidgets('Routing test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial screen is HomePage.
    expect(find.byType(HomePage), findsOneWidget);

  });
}
