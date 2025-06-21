import 'package:avaliador_prova_oral/ui/themes.dart';
import 'package:flutter/material.dart';

Widget myRadioWidget({
    required double groupValue,
    required ValueChanged<double?> onChanged,
  }) {
    Widget buildRadioItem(double value, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 1.3,
            child: Radio<double>(
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (states) => states.contains(WidgetState.selected)
                    ? AppTheme.primaryColor
                    : Colors.grey.withOpacity(0.3),
              ),
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildRadioItem(0.0, '✘'), 
        buildRadioItem(0.5, '◐'), 
        buildRadioItem(1.0, '✔'), 
      ],
    );
  }