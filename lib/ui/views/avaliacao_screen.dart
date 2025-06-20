import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/storage_service.dart';
import '../themes.dart';
import '../viewmodels/avaliacao_viewmodel.dart';
import '../widgets/my_app_bar_widget.dart';
import '../widgets/my_elevated_button.dart';
import '../widgets/my_text_field_widget.dart';
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

  void _salvarENext(BuildContext context, AvaliacaoViewModel viewModel) async {
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

  Widget _radio(double valor, double group, void Function(double?) onChanged) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 1.3,
          child: Radio<double>(
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (states) => states.contains(WidgetState.selected)
                  ? Colors.blue
                  : Colors.grey.withOpacity(0.3),
            ),
            value: valor,
            groupValue: group,
            onChanged: onChanged,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Text(
          valor == 1.0
              ? '✔'
              : valor == 0.5
                  ? '◐'
                  : '✘',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _avaliacaoAluno(BuildContext context, int alunoIndex) {
    final viewModel = context.watch<AvaliacaoViewModel>();
    final perguntaAtual = viewModel.perguntaAtual;
    final resposta = viewModel.respostas[alunoIndex][perguntaAtual];
    final obsController = TextEditingController(
      text: viewModel.observacoes[alunoIndex][perguntaAtual],
    );

    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                viewModel.nomes[alunoIndex].toUpperCase(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 16, color: Colors.transparent),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resposta:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textColorSecondary)),
                  Text('Gramática:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textColorSecondary)),
                ],
              ),
            ),
            const Divider(height: 12, color: Colors.transparent),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _radio(
                  0.0,
                  resposta['resposta']!,
                  (val) => viewModel.definirNota(alunoIndex, perguntaAtual, 'resposta', val!),
                ),
                _radio(
                  0.5,
                  resposta['resposta']!,
                  (val) => viewModel.definirNota(alunoIndex, perguntaAtual, 'resposta', val!),
                ),
                _radio(
                  1.0,
                  resposta['resposta']!,
                  (val) => viewModel.definirNota(alunoIndex, perguntaAtual, 'resposta', val!),
                ),
                const SizedBox(width: 14),
                _radio(
                  0.0,
                  resposta['gramatica']!,
                  (val) => viewModel.definirNota(alunoIndex, perguntaAtual, 'gramatica', val!),
                ),
                _radio(
                  0.5,
                  resposta['gramatica']!,
                  (val) => viewModel.definirNota(alunoIndex, perguntaAtual, 'gramatica', val!),
                ),
                _radio(
                  1.0,
                  resposta['gramatica']!,
                  (val) => viewModel.definirNota(alunoIndex, perguntaAtual, 'gramatica', val!),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.transparent),
            MyTextField(
              onChanged: (texto) => viewModel.definirObservacao(alunoIndex, perguntaAtual, texto),
              controller: obsController,
              inputType: TextInputType.text,
              hintText: 'Observação',
              fillColor: Colors.transparent,
              icon: Icons.assignment_rounded,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AvaliacaoViewModel>();

    return Scaffold(
      appBar: MyAppBar(
        title: 'Pergunta ${viewModel.perguntaAtual + 1} de 5',
        icon: Icons.arrow_back_ios_rounded,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: viewModel.nomes.length,
          itemBuilder: (context, index) => _avaliacaoAluno(context, index),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22),
        child: MyElevatedButton(
          text: viewModel.isUltimaPergunta ? 'Ver Resultados' : 'Próxima Pergunta',
          function: () => _salvarENext(context, viewModel),
        ),
      ),
    );
  }
}
