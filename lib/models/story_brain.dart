import 'scene.dart';

/// R1 — Manages all story scenes and current navigation state.
///
/// Encapsulation: data members are private (leading `_`). UI must only
/// interact with the story through the public methods below.
class StoryBrain {
  // PRIVATE story data ------------------------------------------------------
  int _currentScene = 0;

  /// Placeholder scene list. The user will provide the real script later.
  /// Keep at least 10 unique scenes, 4+ decision points, 3+ endings,
  /// and 2+ options per decision (R-rubric).
  final List<Scene> _scenes = const [
    // 0 — title/opening (decision point 1)
    Scene(
      storyText:
          'TODO: opening narration. The rain hammers the windows of Blackthorn Manor...',
      choices: ['TODO: choice A', 'TODO: choice B'],
      nextScenes: [1, 2],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
    ),
    // 1
    Scene(
      storyText: 'TODO: scene 1 narration.',
      choices: ['TODO: choice A', 'TODO: choice B'],
      nextScenes: [3, 4],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
    ),
    // 2
    Scene(
      storyText: 'TODO: scene 2 narration.',
      choices: ['TODO: choice A', 'TODO: choice B'],
      nextScenes: [5, 6],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
    ),
    // 3
    Scene(
      storyText: 'TODO: scene 3 narration.',
      choices: ['TODO: continue'],
      nextScenes: [7],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
    ),
    // 4
    Scene(
      storyText: 'TODO: scene 4 narration.',
      choices: ['TODO: continue'],
      nextScenes: [8],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
    ),
    // 5
    Scene(
      storyText: 'TODO: scene 5 narration.',
      choices: ['TODO: continue'],
      nextScenes: [9],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
    ),
    // 6
    Scene(
      storyText: 'TODO: scene 6 narration.',
      choices: ['TODO: continue'],
      nextScenes: [9],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
    ),
    // 7 — GOOD ending
    Scene(
      storyText: 'TODO: good-ending narration.',
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
      isEnding: true,
      endingLabel: 'The Truth Revealed — Good Ending',
    ),
    // 8 — NEUTRAL ending
    Scene(
      storyText: 'TODO: neutral-ending narration.',
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
      isEnding: true,
      endingLabel: 'A Case Left Cold — Neutral Ending',
    ),
    // 9 — BAD ending
    Scene(
      storyText: 'TODO: bad-ending narration.',
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/scene_00_placeholder.jpg',
      isEnding: true,
      endingLabel: 'Silenced Forever — Bad Ending',
    ),
  ];

  // PUBLIC API --------------------------------------------------------------
  String getStoryText() => _scenes[_currentScene].storyText;
  List<String> getChoices() => _scenes[_currentScene].choices;
  String getImagePath() => _scenes[_currentScene].imagePath;
  bool isGameOver() => _scenes[_currentScene].isEnding;
  String getEndingLabel() => _scenes[_currentScene].endingLabel ?? 'The End';

  /// Advance the story based on the choice index pressed.
  void nextScene(int choiceIndex) {
    final scene = _scenes[_currentScene];
    if (scene.isEnding) return;
    if (choiceIndex < 0 || choiceIndex >= scene.nextScenes.length) return;
    _currentScene = scene.nextScenes[choiceIndex];
  }

  /// Reset the story to the very beginning (used by the Restart button — R6).
  void restart() {
    _currentScene = 0;
  }
}
