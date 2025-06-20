import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/tela_inicial_viewmodel.dart';
import '../widgets/my_app_bar_widget.dart';
import '../widgets/my_elevated_button.dart';
import '../widgets/my_text_field_widget.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TelaInicialViewModel>(context, listen: false);
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.03),
              Image.asset(
                'assets/images/gradexLogo.png',
                height: height * 0.4,
                fit: BoxFit.contain,
              ),
              const Text('Digite a quantidade de alunos:'),
              const SizedBox(height: 30),
              MyTextField(
                controller: viewModel.controller,
                hintText: 'Exemplo: 2',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              MyElevatedButton(
                function: () => viewModel.iniciar(context),
                text: 'Iniciar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
