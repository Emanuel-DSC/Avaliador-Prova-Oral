import 'package:flutter/material.dart';
import '../../utils/themes.dart';

class QuestionResultDetail extends StatelessWidget {
  final int questionNumber;
  final Map<String, double> resposta;
  final String observation;

  const QuestionResultDetail({
    super.key,
    required this.questionNumber,
    required this.resposta,
    required this.observation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pergunta $questionNumber:',
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.blueGrey),
        ),
        const Divider(height: 14, color: Colors.transparent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              color: AppTheme.corIconeNota(resposta['resposta'] ?? 0.0),
            ),
            const SizedBox(width: 20),
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
              color: AppTheme.corIconeNota(resposta['gramatica'] ?? 0.0),
            ),
          ],
        ),
        const Divider(height: 14, color: Colors.transparent),
        if (observation.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.feedback_rounded, color: Colors.white54),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Obs: $observation',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 6),
      ],
    );
  }
}