import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coma_bem/main.dart';

void main() {
  testWidgets('busca filtra restaurantes pela pesquisa', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    expect(find.text('Burger Joint'), findsOneWidget);
    expect(find.text('Sushi House'), findsOneWidget);

    final Finder searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'sushi');
    await tester.pump();

    expect(find.text('Sushi House'), findsOneWidget);
    expect(find.text('Burger Joint'), findsNothing);
  });
}
