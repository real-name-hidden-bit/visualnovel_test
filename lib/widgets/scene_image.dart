import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Frames the scene image with a vintage sepia border + dark vignette.
/// Falls back to a "missing image" panel if the asset isn't bundled yet.
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
              // Slight sepia/desaturation for vintage feel.
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
            // Dark vignette overlay.
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
