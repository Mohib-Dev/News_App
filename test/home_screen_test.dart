import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view/home_screen.dart';

import 'helper/helper_test.mocks.dart';

void main() {
  late MockNewsViewModel mockNewsViewModel;
  late HomeScreen homeScreen;

  setUp(() {
    mockNewsViewModel = MockNewsViewModel();
    homeScreen = HomeScreen(newsViewModel: mockNewsViewModel);
  });
  testWidgets('HomeScreen UI components test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(newsViewModel: MockNewsViewModel()),
    ));

    expect(find.text('News'), findsOneWidget);

    expect(find.byIcon(Icons.category), findsOneWidget);

    expect(find.byType(PopupMenuButton), findsOneWidget);

    expect(find.byType(FutureBuilder), findsNWidgets(2));

    expect(find.byType(SpinKitFadingCircle), findsOneWidget);
  });

  testWidgets('HomeScreen category selection test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(newsViewModel: MockNewsViewModel()),
    ));

    await tester.tap(find.byIcon(Icons.category));
    await tester.pumpAndSettle();

    expect(find.byType(CategoriesScreen), findsOneWidget);

    await tester.tap(find.text('BBC News').last);
    await tester.pumpAndSettle();

    expect(find.text('BBC News'), findsOneWidget);
  });
}
