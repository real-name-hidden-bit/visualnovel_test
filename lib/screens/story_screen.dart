import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/story_brain.dart';
import '../theme/app_theme.dart';
import '../widgets/choice_button.dart';
import '../widgets/scene_image.dart';
import 'ending_screen.dart';


class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final StoryBrain _brain = StoryBrain();
  final AudioPlayer _bgm = AudioPlayer();   
  final AudioPlayer _sfx = AudioPlayer();   

  bool _bgmAvailable = false;
  bool _doorAvailable = false;

  static const _discoverySceneIndices = {1, 3, 4, 5};

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
    _bgmAvailable  = await _assetExists('assets/audio/bgm_mystery.mp3');
    _doorAvailable = await _assetExists('assets/audio/sfx_door.mp3');
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

  void _playSfx(String fileName, {required bool available}) {
    if (!available) return;
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
    setState(() {
      _brain.nextScene(index);
    });

    final dest = _brain.currentScene;
    if (!_brain.isGameOver() && _discoverySceneIndices.contains(dest)) {
      _playSfx('sfx_door.mp3', available: _doorAvailable);
    }

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
