import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/themes.dart';
import 'ui/viewmodels/inicio_screen_viewmodel.dart';
import 'ui/views/inicio_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TelaInicialViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: const TelaInicial(),
      ),
    ),
  );
}
