import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/story_brain.dart';
import '../theme/app_theme.dart';
import '../widgets/choice_button.dart';
import '../widgets/scene_image.dart';
import 'ending_screen.dart';

/// Page 2 — main STORY page. R2 (StatefulWidget + setState).
///
/// Vertical layout (top → bottom):
///   • AppBar  — story title, small chapter indicator
///   • SafeArea body (Column)
///       1. SceneImage           (Expanded flex 5)  — picture for current scene
///       2. VintageDivider
///       3. Card with storyText  (Expanded flex 4)  — scrollable narration
///       4. Choice buttons       (flex 3)           — ElevatedButtons in a Column
class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final StoryBrain _brain = StoryBrain();
  final AudioPlayer _bgm = AudioPlayer();   // R5 — background loop
  final AudioPlayer _sfx = AudioPlayer();   // R5 — key-moment SFX

  // Audio is OFF until we confirm the asset is actually bundled. This avoids
  // the audioplayers Windows-side hang when an AssetSource path is missing.
  bool _bgmAvailable = false;
  bool _sfxAvailable = false;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _initAudio() async {
    _bgmAvailable = await _assetExists('assets/audio/bgm_mystery.mp3');
    _sfxAvailable = await _assetExists('assets/audio/sfx_thunder.mp3');
    if (_bgmAvailable) {
      try {
        await _bgm.setReleaseMode(ReleaseMode.loop);
        await _bgm.play(AssetSource('audio/bgm_mystery.mp3'), volume: 0.4);
      } catch (e) {
        debugPrint('BGM failed: $e');
        _bgmAvailable = false;
      }
    }
  }

  void _playSfx(String fileName) {
    if (!_sfxAvailable) return;
    // Fire-and-forget; never await on the UI thread.
    _sfx.play(AssetSource('audio/$fileName'), volume: 0.9).catchError((e) {
      debugPrint('SFX failed: $e');
    });
  }

  @override
  void dispose() {
    _bgm.dispose();
    _sfx.dispose();
    super.dispose();
  }

  void _onChoice(int index) {
    // R5 — example key-moment cue
    _playSfx('sfx_thunder.mp3');

    setState(() {
      _brain.nextScene(index);
    });

    if (_brain.isGameOver()) {
      _bgm.stop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => EndingScreen(
            endingLabel: _brain.getEndingLabel(),
            endingText: _brain.getStoryText(),
            endingImage: _brain.getImagePath(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final choices = _brain.getChoices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('B L A C K W O O D   M A N O R'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              // 1) Scene image
              Expanded(
                flex: 5,
                child: SceneImage(imagePath: _brain.getImagePath()),
              ),
              const VintageDivider(),
              // 2) Narration card
              Expanded(
                flex: 4,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Text(
                        _brain.getStoryText(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // 3) Choices
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < choices.length; i++)
                      ChoiceButton(
                        label: choices[i],
                        onPressed: () => _onChoice(i),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppTheme.ink,
    );
  }
}
