import 'package:avaliador_prova_oral/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieDisplay extends StatelessWidget {
  final double score;

  const LottieDisplay({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    bool isScoreTen = (score == 10.0);

    if (isScoreTen) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(255, 0, 110, 255),
              BlendMode.modulate,
            ),
            child: Lottie.asset(
              animationTen,
              width: 150,
              height: 150,
              repeat: true,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.modulate,
            ),
            child: Lottie.asset(
              animationCongrats,
              width: 150,
              height: 150,
              repeat: false,
              fit: BoxFit.cover,
            ),
          ),
          Visibility(
            visible:
                true, 
            child: Text(
              score.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
            ),
          ),
        ],
      );
    }
  }
}
