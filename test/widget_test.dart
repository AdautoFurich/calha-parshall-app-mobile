import 'package:flutter_test/flutter_test.dart';

import 'package:calha_parshall_app/main.dart';

void main() {
  testWidgets('exibe o formulario de dimensionamento', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalhaParshallApp());

    expect(find.text('Dimensionamento da Calha Parshall'), findsOneWidget);
    expect(find.text('População da cidade'), findsOneWidget);
    expect(
      find.text('Consumo diário por habitante em litros'),
      findsOneWidget,
    );
    expect(find.text('Calcular'), findsOneWidget);
    expect(find.text('Limpar'), findsOneWidget);
  });
}
