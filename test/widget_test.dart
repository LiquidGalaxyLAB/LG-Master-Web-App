// -------------------------------------------- WIDGET TEST EXAMPLE --------------------------------------------
// This is a basic Flutter widget test
// To perform an interaction with a widget in your test, use the WidgetTester utility in the flutter_test package
// For example, you can send tap and scroll gestures
// You can also use WidgetTester to find child widgets in the widget tree, read text, and verify that the values of widget properties are correct

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:flutter_test/flutter_test.dart'; // Imports the testing framework (which contains testWidgets, expect, WidgetTester, etc.)
import 'package:lg_master_web_app/main.dart'; // Imports the app entry point (MyApp class) so the test can build and interact with it

// ---------------------- main() void ----------------------
// This is the entry point and where all the tests are run from
// This code is just an example
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // This line defines a widget test case called "Counter increments smoke test"
    // testWidgets is a Flutter function for running widget tests
    // tester is a WidgetTester object used to interact with and test widgets

    await tester.pumpWidget(const MyApp());
    // Builds the root widget of the app (MyApp())
    // Renders (or pumps) the widget tree once
    // await pauses the execution of the code until this line is done

    // --------- Verify that our counter starts at 0 ---------
    // Uses expectations to check the initial state

    expect(find.text('0'), findsOneWidget);
    // Looks for a widget that contains the text "0"
    // Should be found once (findsOneWidget)

    expect(find.text('1'), findsNothing);
    // Looks for a widget that contains the text "1"
    // Should not be found (findsNothing)

    // --------- Tap the '+' icon and trigger a frame ---------
    await tester.tap(find.byIcon(Icons.add));
    // Simulates a tap gesture on the widget with the + (Icons.add) icon

    await tester.pump();
    // Calls pump() to rebuild the widget tree and process the UI state change

    // --------- Verify that our counter has incremented ---------
    // After tapping, 0 should not exist and 1 should be found instead
    // Because the count has been incremented

    expect(find.text('0'), findsNothing);
    // Looks for a widget that contains the text "0"
    // Should not be found (findsNothing)

    expect(find.text('1'), findsOneWidget);
    // Looks for a widget that contains the text "1"
    // Should be found once (findsOneWidget)
  });
}
