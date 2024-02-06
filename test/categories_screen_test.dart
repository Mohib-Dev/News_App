import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/view/categories_screen.dart';

void main() {
  testWidgets('Categories Screen displays correct categories',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesScreen(),
    ));

    // Verify that the categories are displayed
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Entertainment'), findsOneWidget);
    expect(find.text('Health'), findsOneWidget);
    expect(find.text('Sports'), findsOneWidget);
    expect(find.text('Business'), findsOneWidget);
    expect(find.text('Technology'), findsOneWidget);
  });

  testWidgets('Categories Screen switches category when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesScreen(),
    ));

    expect(find.text('General'), findsOneWidget);

    await tester.tap(find.text('Entertainment'));
    await tester.pump();

    expect(find.text('Entertainment'), findsOneWidget);
  });
}
