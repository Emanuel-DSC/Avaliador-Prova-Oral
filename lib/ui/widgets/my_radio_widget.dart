import 'package:flutter/material.dart';

import '../../utils/themes.dart';

Widget myRadioWidget({
  required double groupValue,
  required ValueChanged<double?> onChanged,
}) {
  Widget buildRadioItem(double value, IconData icon, Color iconColor) {
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
        const Divider(height: 8),
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ],
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      buildRadioItem(0.0, Icons.done_all_rounded, Colors.blueGrey),
      buildRadioItem(0.5, Icons.remove_done_rounded, Colors.blueGrey),
      buildRadioItem(1.0, Icons.close_rounded, Colors.blueGrey),
    ],
  );
}
