import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/view/home_screen.dart';
import 'package:news_app/view/splash_screen.dart';

void main() {
  testWidgets('Splash Screen displays UI elements and navigates to HomeScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SplashScreen(),
    ));

    expect(find.text('TOP HEADLINES'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(SpinKitWave), findsOneWidget);

    await tester.pump(const Duration(seconds: 10));
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
