import 'package:albums/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home has title', (WidgetTester tester) async {
    await tester.pumpWidget(AlbumsApp());
    final titleFinder = find.text('Albums');
    expect(titleFinder, findsOneWidget);
  });
}
