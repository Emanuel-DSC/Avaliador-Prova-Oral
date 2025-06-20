class AvaliacaoViewModel {
  final List<String> nomes;
  final List<List<Map<String, double>>> respostas;
  final List<List<String>> observacoes;

  AvaliacaoViewModel(this.nomes)
      : respostas = List.generate(
            nomes.length, (_) => List.generate(5, (_) => {'resposta': 0.0, 'gramatica': 0.0})),
        observacoes = List.generate(nomes.length, (_) => List.generate(5, (_) => ''));

  void definirNota(int alunoIndex, int perguntaIndex, String tipo, double valor) {
    respostas[alunoIndex][perguntaIndex][tipo] = valor;
  }

  void definirObservacao(int alunoIndex, int perguntaIndex, String texto) {
    observacoes[alunoIndex][perguntaIndex] = texto;
  }

  double calcularNotaFinal(int alunoIndex) {
    double total = 0.0;
    for (var resp in respostas[alunoIndex]) {
      total += (resp['resposta'] ?? 0) + (resp['gramatica'] ?? 0);
    }
    return total;
  }
}