import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'story_screen.dart';

/// Page 1 — STORY TITLE.
/// Layout (top → bottom):
///   • AppBar           (vintage brand bar, optional)
///   • SafeArea
///     - Expanded image area (cover art / mood image)
///     - Story title (Cinzel serif, large)
///     - Subtitle / tagline
///     - "Begin" ElevatedButton  → pushes StoryScreen
///     - Tiny credit line ("An AI Image" disclosure if used)
class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar on title to keep cinematic feel.
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Title cover art (replace with assets/images/ui/title_bg.jpg later).
            Image.asset(
              'assets/images/ui/title_bg.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppTheme.ink),
            ),
            // Darkening overlay for legibility + mood.
            Container(color: Colors.black.withValues(alpha: 0.55)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  Text(
                    'A MURDER MYSTERY',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'BLACKWOOD\nMANOR',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16),
                  Container(height: 1, width: 140, color: AppTheme.sepia),
                  const SizedBox(height: 16),
                  Text(
                    'A storm. A corpse. One hour until the police arrive.\nFind the killer before the truth slips away.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(flex: 4),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const StoryScreen(),
                        ),
                      );
                    },
                    child: const Text('B E G I N'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'AI Image · For academic use',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.sepia,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
