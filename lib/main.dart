import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/themes.dart';
import 'ui/viewmodels/tela_inicial_viewmodel.dart';
import 'ui/views/tela_inicial.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return TelaInicialViewModel();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: const TelaInicial(),
      ),
    ),
  );
}

