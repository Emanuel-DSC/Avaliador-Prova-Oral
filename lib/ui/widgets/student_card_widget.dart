import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/themes.dart';
import '../viewmodels/avaliacao_viewmodel.dart';
import 'my_radio_widget.dart'; 
import 'my_text_field_widget.dart'; 

class StudentEvaluationCard extends StatefulWidget {
  final int alunoIndex;

  const StudentEvaluationCard({
    super.key,
    required this.alunoIndex,
  });

  @override
  State<StudentEvaluationCard> createState() => _StudentEvaluationCardState();
}

class _StudentEvaluationCardState extends State<StudentEvaluationCard> {
  late TextEditingController _obsController;

  @override
  void initState() {
    super.initState();
    _obsController = TextEditingController();
    _updateControllerText(); 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateControllerText();
  }

  void _updateControllerText() {
    final viewModel = Provider.of<AvaliacaoViewModel>(context, listen: false);
    final currentObservation =
        viewModel.observacoes[widget.alunoIndex][viewModel.perguntaAtual];
    if (_obsController.text != currentObservation) {
      _obsController.text = currentObservation;
      _obsController.selection = TextSelection.fromPosition(
          TextPosition(offset: _obsController.text.length));
    }
  }


  @override
  void dispose() {
    _obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AvaliacaoViewModel>();
    final perguntaAtual = viewModel.perguntaAtual;
    final resposta = viewModel.respostas[widget.alunoIndex][perguntaAtual];

    _obsController.removeListener(_updateViewModelObservation);
    _obsController.addListener(_updateViewModelObservation); 

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
                viewModel.nomes[widget.alunoIndex].toUpperCase(),
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
                Expanded(
                  child: myRadioWidget( 
                    groupValue: resposta['resposta']!,
                    onChanged: (val) => viewModel.definirNota(
                        widget.alunoIndex, perguntaAtual, 'resposta', val!),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: myRadioWidget(
                    groupValue: resposta['gramatica']!,
                    onChanged: (val) => viewModel.definirNota(
                        widget.alunoIndex, perguntaAtual, 'gramatica', val!),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.transparent),
            MyTextField(
              controller: _obsController,
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

  void _updateViewModelObservation() {
    final viewModel = Provider.of<AvaliacaoViewModel>(context, listen: false);
    viewModel.definirObservacao(
        widget.alunoIndex, viewModel.perguntaAtual, _obsController.text);
  }
}
