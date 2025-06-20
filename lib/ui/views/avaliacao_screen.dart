import 'package:avaliador_prova_oral/ui/themes.dart';
import 'package:avaliador_prova_oral/ui/widgets/my_app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../viewmodels/avaliacao_viewmodel.dart';
import '../widgets/my_elevated_button.dart';
import '../widgets/my_text_field_widget.dart';
import 'resultado_screen.dart';

class AvaliacaoScreen extends StatefulWidget {
  final List<String> nomes;
  const AvaliacaoScreen({super.key, required this.nomes});

  @override
  _AvaliacaoScreenState createState() => _AvaliacaoScreenState();
}

class _AvaliacaoScreenState extends State<AvaliacaoScreen> {
  late AvaliacaoViewModel viewModel;
  int perguntaAtual = 0;

  @override
  void initState() {
    super.initState();
    viewModel = AvaliacaoViewModel(widget.nomes);
  }

  void _salvarENext() async {
    if (perguntaAtual < 4) {
      setState(() {
        perguntaAtual++;
      });
    } else {
      await StorageService.saveData({
        'nomes': widget.nomes,
        'respostas': viewModel.respostas,
        'observacoes': viewModel.observacoes,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultadoScreen(
            respostas: viewModel.respostas,
            nomes: widget.nomes,
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
            (states) => states.contains(WidgetState.selected) ? Colors.blue : Colors.grey.withOpacity(0.3),
          ),
            value: valor,
            groupValue: group,
            onChanged: onChanged,
            visualDensity: VisualDensity.standard,
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

  Widget _avaliacaoAluno(int alunoIndex) {
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
              child: Text(widget.nomes[alunoIndex].toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
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
                    (val) => setState(() => viewModel.definirNota(
                        alunoIndex, perguntaAtual, 'resposta', val!))),
                _radio(
                    0.5,
                    resposta['resposta']!,
                    (val) => setState(() => viewModel.definirNota(
                        alunoIndex, perguntaAtual, 'resposta', val!))),
                _radio(
                    1.0,
                    resposta['resposta']!,
                    (val) => setState(() => viewModel.definirNota(
                        alunoIndex, perguntaAtual, 'resposta', val!))),
                const SizedBox(width: 14),
                _radio(
                    0.0,
                    resposta['gramatica']!,
                    (val) => setState(() => viewModel.definirNota(
                        alunoIndex, perguntaAtual, 'gramatica', val!))),
                _radio(
                    0.5,
                    resposta['gramatica']!,
                    (val) => setState(() => viewModel.definirNota(
                        alunoIndex, perguntaAtual, 'gramatica', val!))),
                _radio(
                    1.0,
                    resposta['gramatica']!,
                    (val) => setState(() => viewModel.definirNota(
                        alunoIndex, perguntaAtual, 'gramatica', val!))),
              ],
            ),
            const Divider(height: 20, color: Colors.transparent),
            MyTextField(
              onChanged: (texto) =>
                  viewModel.definirObservacao(alunoIndex, perguntaAtual, texto),
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
    return Scaffold(
      appBar: MyAppBar(
        title: 'Pergunta ${perguntaAtual + 1} de 5',
        icon: Icons.arrow_back_ios_rounded,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.nomes.length,
          itemBuilder: (context, index) => _avaliacaoAluno(index),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22),
        child: MyElevatedButton(
          text: perguntaAtual < 4 ? 'Próxima Pergunta' : 'Ver Resultados',
          function: _salvarENext,
        ),
      ),
    );
  }
}
