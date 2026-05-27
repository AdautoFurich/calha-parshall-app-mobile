import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalhaParshallApp());
}

class CalhaParshallApp extends StatelessWidget {
  const CalhaParshallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calha Parshall',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class CalhaParshall {
  final String larguraW;
  final double vazaoMinima;
  final double vazaoMaxima;
  final double k;
  final double n;
  final double alturaBordaE;

  CalhaParshall(
    this.larguraW,
    this.vazaoMinima,
    this.vazaoMaxima,
    this.k,
    this.n,
    this.alturaBordaE,
  );

  bool aceitaVazao(double vazaoLitrosPorSegundo) {
    return vazaoLitrosPorSegundo >= vazaoMinima &&
        vazaoLitrosPorSegundo <= vazaoMaxima;
  }

  double calcularAlturaAgua(double vazaoMetroCubicoPorSegundo) {
    return pow(vazaoMetroCubicoPorSegundo / k, 1.0 / n).toDouble();
  }

  double calcularPercentualOcupado(double alturaAgua) {
    double alturaBordaMetros = alturaBordaE / 100.0;
    return (alturaAgua * 100.0) / alturaBordaMetros;
  }

  bool estaSegura(double alturaAgua) {
    return calcularPercentualOcupado(alturaAgua) <= 70.0;
  }
}

class ResultadoCalha {
  final int populacao;
  final double consumoDiario;
  final double vazaoDia;
  final double vazaoLitrosPorSegundo;
  final double vazaoMetroCubicoPorSegundo;
  final CalhaParshall? calhaEscolhida;
  final double alturaAgua;
  final double percentualOcupado;

  ResultadoCalha({
    required this.populacao,
    required this.consumoDiario,
    required this.vazaoDia,
    required this.vazaoLitrosPorSegundo,
    required this.vazaoMetroCubicoPorSegundo,
    required this.calhaEscolhida,
    required this.alturaAgua,
    required this.percentualOcupado,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController populacaoController = TextEditingController();
  final TextEditingController consumoController = TextEditingController();

  ResultadoCalha? resultado;

  final List<CalhaParshall> calhas = [
    CalhaParshall('76 mm (3")', 0.85, 53.8, 0.1771, 1.5447, 38.1),
    CalhaParshall('152 mm (6")', 1.52, 110.4, 0.3812, 1.530, 45.7),
    CalhaParshall('229 mm (9")', 2.55, 251.9, 0.5354, 1.530, 61.0),
    CalhaParshall("305 mm (1')", 3.11, 455.6, 0.6909, 1.522, 91.5),
    CalhaParshall("457 mm (1 1/2')", 4.25, 696.2, 1.0560, 1.538, 91.5),
    CalhaParshall("610 mm (2')", 11.89, 936.7, 1.4290, 1.550, 91.5),
    CalhaParshall("915 mm (3')", 17.26, 1426.0, 2.1840, 1.5666, 91.5),
    CalhaParshall("1220 mm (4')", 36.79, 1921.0, 2.9630, 1.5738, 91.5),
    CalhaParshall("1525 mm (5')", 62.80, 2422.0, 3.7320, 1.587, 91.5),
  ];

  void calcular() {
    final int? populacao = int.tryParse(populacaoController.text.trim());

    final double? consumoDiario = double.tryParse(
      consumoController.text.trim().replaceAll(',', '.'),
    );

    if (populacao == null || consumoDiario == null) {
      mostrarMensagem('Informe valores válidos.');
      return;
    }

    if (populacao <= 0 || consumoDiario <= 0) {
      mostrarMensagem('Os valores devem ser maiores que zero.');
      return;
    }

    final double vazaoDia = populacao * consumoDiario;
    final double vazaoLitrosPorSegundo = vazaoDia / 86400.0;
    final double vazaoMetroCubicoPorSegundo = vazaoLitrosPorSegundo / 1000.0;

    CalhaParshall? calhaEscolhida;
    double alturaAgua = 0;
    double percentualOcupado = 0;

    for (final calha in calhas) {
      if (calha.aceitaVazao(vazaoLitrosPorSegundo)) {
        alturaAgua = calha.calcularAlturaAgua(vazaoMetroCubicoPorSegundo);
        percentualOcupado = calha.calcularPercentualOcupado(alturaAgua);

        if (calha.estaSegura(alturaAgua)) {
          calhaEscolhida = calha;
          break;
        }
      }
    }

    setState(() {
      resultado = ResultadoCalha(
        populacao: populacao,
        consumoDiario: consumoDiario,
        vazaoDia: vazaoDia,
        vazaoLitrosPorSegundo: vazaoLitrosPorSegundo,
        vazaoMetroCubicoPorSegundo: vazaoMetroCubicoPorSegundo,
        calhaEscolhida: calhaEscolhida,
        alturaAgua: alturaAgua,
        percentualOcupado: percentualOcupado,
      );
    });
  }

  void limpar() {
    setState(() {
      populacaoController.clear();
      consumoController.clear();
      resultado = null;
    });
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  void dispose() {
    populacaoController.dispose();
    consumoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = resultado;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icon/umfg.png',
                      height: 58,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 12),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Dimensionamento da Calha Parshall '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.water_drop,
                              size: 27,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: populacaoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'População da cidade',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.people),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: consumoController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Consumo diário por habitante em litros',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.local_drink),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: calcular,
                            icon: const Icon(Icons.calculate),
                            label: const Text('Calcular'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: limpar,
                            icon: const Icon(Icons.cleaning_services),
                            label: const Text('Limpar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (r != null) ResultadoWidget(resultado: r),
          ],
        ),
      ),
    );
  }
}

class ResultadoWidget extends StatelessWidget {
  final ResultadoCalha resultado;

  const ResultadoWidget({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    final calha = resultado.calhaEscolhida;

    return Column(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text('Dados Informados'),
            subtitle: Text(
              'População: ${resultado.populacao} habitantes\n'
              'Consumo diário: ${resultado.consumoDiario.toStringAsFixed(2)} L/hab/dia',
            ),
          ),
        ),
        Card(
          elevation: 2,
          child: ListTile(
            leading: const Icon(Icons.speed, color: Colors.orange),
            title: const Text('Cálculo da Vazão'),
            subtitle: Text(
              'Vazão por dia: ${resultado.vazaoDia.toStringAsFixed(2)} L/dia\n'
              'Vazão por segundo: ${resultado.vazaoLitrosPorSegundo.toStringAsFixed(2)} L/s\n'
              'Vazão convertida: ${resultado.vazaoMetroCubicoPorSegundo.toStringAsFixed(5)} m³/s',
            ),
          ),
        ),
        if (calha == null)
          const Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text('Nenhuma calha segura encontrada'),
              subtitle: Text(
                'Será necessário utilizar uma calha maior ou revisar os dados informados.',
              ),
            ),
          )
        else ...[
          Card(
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Calha Parshall Escolhida'),
              subtitle: Text(
                'Largura W: ${calha.larguraW}\n'
                'Faixa de vazão: ${calha.vazaoMinima.toStringAsFixed(2)} até ${calha.vazaoMaxima.toStringAsFixed(2)} L/s\n'
                'Constante K: ${calha.k.toStringAsFixed(4)}\n'
                'Constante n: ${calha.n.toStringAsFixed(4)}\n'
                'Altura da borda E: ${calha.alturaBordaE.toStringAsFixed(2)} cm',
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(
                resultado.percentualOcupado <= 70.0
                    ? Icons.verified
                    : Icons.dangerous,
                color: resultado.percentualOcupado <= 70.0
                    ? Colors.green
                    : Colors.red,
              ),
              title: const Text('Verificação de Transbordamento'),
              subtitle: Text(
                'Altura da água H: ${resultado.alturaAgua.toStringAsFixed(2)} m\n'
                'Altura da borda E: ${(calha.alturaBordaE / 100.0).toStringAsFixed(2)} m\n'
                'Percentual ocupado: ${resultado.percentualOcupado.toStringAsFixed(2)}%\n\n'
                '${resultado.percentualOcupado <= 70.0 ? 'Resultado: OK. Baixa probabilidade de transbordamento.' : 'Resultado: risco de transbordamento.'}',
              ),
            ),
          ),
        ],
      ],
    );
  }
}
