import 'package:avaliador_prova_oral/ui/widgets/student_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/storage_service.dart';
import '../viewmodels/avaliacao_viewmodel.dart';
import '../widgets/my_app_bar_widget.dart';
import '../widgets/my_elevated_button.dart';
import 'resultado_screen.dart';

class AvaliacaoScreen extends StatelessWidget {
  final List<String> nomes;

  const AvaliacaoScreen({super.key, required this.nomes});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = AvaliacaoViewModel();
        viewModel.iniciar(nomes);
        return viewModel;
      },
      child: const _AvaliacaoBody(),
    );
  }
}

class _AvaliacaoBody extends StatelessWidget {
  const _AvaliacaoBody();

  Future<void> _handleNextOrFinish(
      BuildContext context, AvaliacaoViewModel viewModel) async {
    if (!viewModel.isUltimaPergunta) {
      viewModel.proximaPergunta();
    } else {
      await StorageService.saveData({
        'nomes': viewModel.nomes,
        'respostas': viewModel.respostas,
        'observacoes': viewModel.observacoes,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultadoScreen(
            nomes: viewModel.nomes,
            respostas: viewModel.respostas,
            observacoes: viewModel.observacoes,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AvaliacaoViewModel>();

    return Scaffold(
      appBar: MyAppBar(
        title: 'Pergunta ${viewModel.perguntaAtual + 1} de 5',
        icon: Icons.arrow_back_ios_rounded,
        onTap: () {
          if (viewModel.perguntaAtual > 0) {
            viewModel.anteriorPergunta();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: viewModel.nomes.length,
          itemBuilder: (context, index) =>
              StudentEvaluationCard(alunoIndex: index),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22),
        child: MyElevatedButton(
          text: viewModel.isUltimaPergunta
              ? 'Ver Resultados'
              : 'Próxima Pergunta',
          function: () => _handleNextOrFinish(context, viewModel),
        ),
      ),
    );
  }
}
