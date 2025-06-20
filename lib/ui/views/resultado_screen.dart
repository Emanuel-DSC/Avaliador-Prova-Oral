import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../themes.dart';
import '../widgets/my_app_bar_widget.dart';

class ResultadoScreen extends StatelessWidget {
  final List<List<Map<String, double>>> respostas;
  final List<String> nomes;
  final List<List<String>> observacoes;

  const ResultadoScreen({
    super.key,
    required this.respostas,
    required this.nomes,
    required this.observacoes,
  });

  double _calcularNota(List<Map<String, double>> alunoRespostas) {
    double total = 0.0;
    for (var resp in alunoRespostas) {
      total += (resp['resposta'] ?? 0) + (resp['gramatica'] ?? 0);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Resultados',
        icon: Icons.arrow_back_ios_new_rounded,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Swiper(
          pagination: const SwiperPagination(),
          itemCount: respostas.length,
          itemBuilder: (context, index) {
            final nota = _calcularNota(respostas[index]);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          nomes[index].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...List.generate(5, (i) {
                          final resposta = respostas[index][i];
                          final obs = observacoes[index][i];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pergunta ${i + 1}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    color: Colors.blueGrey),
                              ),
                              const Divider(
                                  height: 14, color: Colors.transparent),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Resposta:',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    resposta['resposta'] == 1.0
                                        ? Icons.done_all_rounded
                                        : resposta['resposta'] == 0.5
                                            ? Icons.remove_done_rounded
                                            : Icons.close_rounded,
                                    color: AppTheme.corIconeNota(
                                        resposta['resposta'] ?? 0.0),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'Gramática:',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    resposta['gramatica'] == 1.0
                                        ? Icons.done_all_rounded
                                        : resposta['gramatica'] == 0.5
                                            ? Icons.remove_done_rounded
                                            : Icons.close_rounded,
                                    color: AppTheme.corIconeNota(
                                        resposta['gramatica'] ?? 0.0),
                                  ),
                                ],
                              ),
                              const Divider(
                                  height: 14, color: Colors.transparent),
                              if (obs.trim().isNotEmpty)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.feedback_rounded,
                                          color: Colors.white54),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Obs: $obs',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 6),
                            ],
                          );
                        }),
                        const Divider(color: Colors.transparent, height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: Text(
                            'Nota final: ${nota.toStringAsFixed(1)} / 10'
                                .toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
