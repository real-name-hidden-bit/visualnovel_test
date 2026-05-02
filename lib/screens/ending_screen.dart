import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/choice_button.dart';
import '../widgets/scene_image.dart';
import 'title_screen.dart';

/// Page 3 — END SCREEN (R6).
///
/// Layout:
///   • AppBar  — "An Ending"
///   • SafeArea body
///       - SceneImage of final scene
///       - VintageDivider
///       - Ending label  (e.g. "Good Ending")
///       - Closing narration in a Card
///       - "RESTART" ElevatedButton — returns to TitleScreen and resets story
class EndingScreen extends StatelessWidget {
  final String endingLabel;
  final String endingText;
  final String endingImage;

  const EndingScreen({
    super.key,
    required this.endingLabel,
    required this.endingText,
    required this.endingImage,
  });

  void _restart(BuildContext context) {
    // R6 — returning to title and constructing a fresh StoryBrain there
    // resets the story from the beginning.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const TitleScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A N   E N D I N G')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Expanded(flex: 5, child: SceneImage(imagePath: endingImage)),
              const VintageDivider(),
              Text(
                endingLabel,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Expanded(
                flex: 4,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Text(
                        endingText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ChoiceButton(
                label: 'R E S T A R T',
                onPressed: () => _restart(context),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppTheme.ink,
    );
  }
}
