import 'package:flutter/material.dart';
import '../views/nome_alunos_screen.dart';

class TelaInicialViewModel extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  void iniciar(BuildContext context) {
    final int? quantidade = int.tryParse(controller.text);
    if (quantidade != null && quantidade > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NomeAlunosScreen(quantidade: quantidade),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
