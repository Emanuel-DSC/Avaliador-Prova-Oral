import 'package:flutter/material.dart';

class AvaliacaoViewModel extends ChangeNotifier {
  late List<String> _nomes;
  late List<List<Map<String, double>>> _respostas;
  late List<List<String>> _observacoes;
  int _perguntaAtual = 0;

  List<String> get nomes => _nomes;
  List<List<Map<String, double>>> get respostas => _respostas;
  List<List<String>> get observacoes => _observacoes;
  int get perguntaAtual => _perguntaAtual;

  void iniciar(List<String> nomes) {
    _nomes = nomes;
    _respostas = List.generate(
      nomes.length,
      (_) => List.generate(5, (_) => {'resposta': 0.0, 'gramatica': 0.0}),
    );
    _observacoes = List.generate(
      nomes.length,
      (_) => List.generate(5, (_) => ''),
    );
    _perguntaAtual = 0;
    notifyListeners();
  }

  void definirNota(int alunoIndex, int perguntaIndex, String tipo, double valor) {
    _respostas[alunoIndex][perguntaIndex][tipo] = valor;
    notifyListeners();
  }

  void definirObservacao(int alunoIndex, int perguntaIndex, String texto) {
    _observacoes[alunoIndex][perguntaIndex] = texto;
    notifyListeners();
  }

  void proximaPergunta() {
    if (_perguntaAtual < 4) {
      _perguntaAtual++;
      notifyListeners();
    }
  }

  bool get isUltimaPergunta => _perguntaAtual == 4;

  double calcularNotaFinal(int alunoIndex) {
    double total = 0.0;
    for (var resposta in _respostas[alunoIndex]) {
      total += (resposta['resposta'] ?? 0.0) + (resposta['gramatica'] ?? 0.0);
    }
    return total;
  }

  void resetar() {
    _nomes = [];
    _respostas = [];
    _observacoes = [];
    _perguntaAtual = 0;
    notifyListeners();
  }
}
