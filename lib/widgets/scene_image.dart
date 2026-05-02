import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SceneImage extends StatelessWidget {
  final String imagePath;
  const SceneImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.sepia, width: 1.5),
        boxShadow: const [
          BoxShadow(color: Colors.black87, blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                0.55, 0.45, 0.10, 0, 0,
                0.40, 0.55, 0.10, 0, 0,
                0.30, 0.35, 0.20, 0, 0,
                0,    0,    0,    1, 0,
              ]),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppTheme.smoke,
                  alignment: Alignment.center,
                  child: const Text(
                    '[ scene image\n  missing ]',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 1.1,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.65)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
