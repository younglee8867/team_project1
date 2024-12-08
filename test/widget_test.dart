// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/FindWay/StationMap.dart';
import 'package:flutter_application_1/FindWay/WriteStation.dart';
import 'package:flutter_application_1/FindWay/minimumTime.dart';
import 'package:flutter_application_1/FindWay/minimumDistance.dart';
import 'package:flutter_application_1/Setting/TermsOfService.dart';
import 'package:flutter_application_1/Setting/PrivacyPolicy.dart';
import 'package:flutter_application_1/favoriteSta.dart';
import 'package:flutter_application_1/Setting/DisplayMode.dart';
import 'package:flutter_application_1/Setting/Settings.dart';
import 'package:flutter_application_1/Setting/LocalServiceTerms.dart';
import 'package:flutter_application_1/SearchSta/SearchSta.dart';
import 'package:flutter_application_1/SearchSta/SearchStaInfo.dart';

/* void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
 */