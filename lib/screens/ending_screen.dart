import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../theme/app_theme.dart';
import '../widgets/choice_button.dart';
import '../widgets/scene_image.dart';
import 'title_screen.dart';


class EndingScreen extends StatefulWidget {
  final String endingLabel;
  final String endingText;
  final String endingImage;

  const EndingScreen({
    super.key,
    required this.endingLabel,
    required this.endingText,
    required this.endingImage,
  });

  @override
  State<EndingScreen> createState() => _EndingScreenState();
}

class _EndingScreenState extends State<EndingScreen> {
  final AudioPlayer _sfx = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playThunder();
  }

  Future<void> _playThunder() async {
    try {
      await rootBundle.load('assets/audio/sfx_thunder.mp3');
    } catch (_) {
      return; // asset not bundled; skip silently
    }
    try {
      await _sfx.play(AssetSource('audio/sfx_thunder.mp3'), volume: 0.9);
    } catch (e) {
      debugPrint('Thunder failed: $e');
    }
  }

  @override
  void dispose() {
    _sfx.dispose();
    super.dispose();
  }

  void _restart(BuildContext context) {
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
              Expanded(flex: 5, child: SceneImage(imagePath: widget.endingImage)),
              const VintageDivider(),
              Text(
                widget.endingLabel,
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
                        widget.endingText,
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
