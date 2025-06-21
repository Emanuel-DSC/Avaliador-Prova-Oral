import 'package:avaliador_prova_oral/ui/widgets/my_app_bar_widget.dart';
import 'package:avaliador_prova_oral/ui/widgets/my_text_field_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/themes.dart';
import 'avaliacao_screen.dart';

class NomeAlunosScreen extends StatefulWidget {
  final int quantidade;
  const NomeAlunosScreen({super.key, required this.quantidade});

  @override
  // ignore: library_private_types_in_public_api
  _NomeAlunosScreenState createState() => _NomeAlunosScreenState();
}

class _NomeAlunosScreenState extends State<NomeAlunosScreen> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.quantidade, (_) => TextEditingController());
  }

  void _iniciarAvaliacao() {
    final nomes = _controllers.map((c) => c.text.trim()).toList();
    if (nomes.every((nome) => nome.isNotEmpty)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AvaliacaoScreen(nomes: nomes),
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return Scaffold(
      appBar: const MyAppBar(
        icon: Icons.arrow_back_ios_rounded,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.03),
              Image.asset('assets/images/gradexLogo.png',
                  height: height * 0.4, fit: BoxFit.contain),
              const SizedBox(height: 20),
              const Text('Digite os nomes dos alunos:'),
              const SizedBox(height: 20),
              ...List.generate(widget.quantidade, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: MyTextField(
                    controller: _controllers[index],
                    hintText: 'Aluno ${index + 1}',
                    inputType: TextInputType.name,
                  ),
                );
              }),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _iniciarAvaliacao,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
