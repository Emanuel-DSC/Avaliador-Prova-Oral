import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color backgroundColor = Color(0xFF2C3E50);
  static const Color textFieldBackgroundColor = Color.fromARGB(255, 65, 91, 117);
  static const Color positiveColor = Color(0xFF50E3C2); 
  static const Color warningColor = Color(0xFFF5A623);  
  static const Color negativeColor = Color(0xFFF5625D); 
  static const Color textColor = Colors.white;
  static const Color textColorSecondary = Colors.grey;

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodyLarge: TextStyle(color: textColor),
      ),
      textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: Color(0x334A90E2),
      selectionHandleColor: primaryColor,
    ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(primaryColor),
      ),
    );
  }

  static Color corIconeNota(double valor) {
    if (valor == 1.0) return positiveColor;
    if (valor == 0.5) return warningColor;
    return negativeColor;
  }
}
