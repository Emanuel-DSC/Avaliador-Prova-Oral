import 'package:flutter/material.dart';

import 'quest_result_detail_widget.dart';

class StudentResultCard extends StatelessWidget {
  final String studentName;
  final List<Map<String, double>> studentRespostas;
  final List<String> studentObservacoes;

  const StudentResultCard({
    super.key,
    required this.studentName,
    required this.studentRespostas,
    required this.studentObservacoes,
  });

  double _calculateStudentTotalScore() {
    double total = 0.0;
    for (var resp in studentRespostas) {
      total += (resp['resposta'] ?? 0) + (resp['gramatica'] ?? 0);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final double finalScore = _calculateStudentTotalScore();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  studentName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(studentRespostas.length, (i) {
                  final resposta = studentRespostas[i];
                  final obs = studentObservacoes[i];
                  return QuestionResultDetail(
                    questionNumber: i + 1,
                    resposta: resposta,
                    observation: obs,
                  );
                }),
                const Divider(color: Colors.transparent, height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Text(
                    'Nota final: ${finalScore.toStringAsFixed(1)} / 10'.toUpperCase(),
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
  }
}