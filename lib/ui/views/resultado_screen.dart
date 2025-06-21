import 'package:avaliador_prova_oral/ui/widgets/students_results_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../widgets/my_app_bar_widget.dart';

class ResultadoScreen extends StatelessWidget {
  final List<List<Map<String, double>>> answers;
  final List<String> names;
  final List<List<String>> observations;

  const ResultadoScreen({
    super.key,
    required this.answers,
    required this.names,
    required this.observations,
  });

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
          itemCount: answers.length,
          itemBuilder: (context, index) {
            return StudentResultCard(
                studentName: names[index],
                studentRespostas: answers[index],
                studentObservacoes: observations[index]);
          },
        ),
      ),
    );
  }
}
