import 'scene.dart';

/// R1 — Manages all story scenes and current navigation state.
///
/// Encapsulation: data members are private (leading `_`). UI must only
/// interact with the story through the public methods below.
class StoryBrain {
  // PRIVATE story data ------------------------------------------------------
  int _currentScene = 0;

  /// "Murder at Blackwood Manor" — full script.
  /// 11 unique scenes · 6 decision points · 5 endings (2 good, 1 neutral, 2 bad).
  ///
  /// Note on R6: ending scenes set `isEnding: true` and supply an
  /// `endingLabel`. The UI routes to a dedicated EndingScreen which provides
  /// the required Restart button, so each ending's `choices` list is empty
  /// here (the script's "Play Again / Restart Game" buttons are realized by
  /// that single Restart button on the end screen).
  final List<Scene> _scenes = const [
    // 0 — Arrival
    Scene(
      storyText:
          "You arrive at the rain-soaked Blackwood Manor. The host, Arjae "
          "Blackwood, lies lifeless on the floor of his study. You only have "
          "an hour before the local police arrive to take over your case.",
      choices: [
        'Inspect the body for clues',
        'Go to the parlor to interrogate the guests',
      ],
      nextScenes: [1, 2],
      imagePath: 'assets/images/scenes/scene_00_arrival.png',
    ),
    // 1 — The Body
    Scene(
      storyText:
          "Kneeling beside the body, you find two strange things: a pocket "
          "watch smashed exactly at midnight, and a torn piece of red fabric "
          "clutched in Arjae's hand.",
      choices: [
        'Search the room for a hidden safe',
        'Look for a guest wearing red clothes',
      ],
      nextScenes: [3, 4],
      imagePath: 'assets/images/scenes/scene_01_body.png',
    ),
    // 2 — The Parlor
    Scene(
      storyText:
          "In the parlor, you find the nervous Business Partner pacing, and "
          "the Maid weeping quietly in the corner. Neither looks entirely "
          "innocent.",
      choices: [
        'Press the Partner for his alibi',
        'Gently ask the Maid what she saw',
      ],
      nextScenes: [5, 4],
      imagePath: 'assets/images/scenes/scene_02_parlor.png',
    ),
    // 3 — The Hidden Safe
    Scene(
      storyText:
          "Behind a crooked painting, you discover a hidden wall safe. It's "
          "unlocked. Inside is a newly drafted will that completely cuts the "
          "Business Partner out of the fortune!",
      choices: [
        'Confront the Partner loudly with the will',
        'Keep quiet and wait for police backup',
      ],
      nextScenes: [6, 7],
      imagePath: 'assets/images/scenes/scene_03_safe.png',
    ),
    // 4 — The Maid in Red
    Scene(
      storyText:
          "You notice the Maid is wearing a red uniform... and the left sleeve "
          "is torn. She cries and swears she only found the body and ran away "
          "in a panic.",
      choices: [
        'Arrest her immediately as the murderer',
        'Believe her and check the security cameras',
      ],
      nextScenes: [8, 9],
      imagePath: 'assets/images/scenes/scene_04_maid.png',
    ),
    // 5 — The Partner's Alibi
    Scene(
      storyText:
          "The Partner sweats profusely. He claims he was down in the manor's "
          "dark cellar fetching wine at midnight. He quickly points his finger "
          "at the Maid.",
      choices: [
        'Go down to the cellar alone to check',
        'Accuse him of lying on the spot',
      ],
      nextScenes: [10, 6],
      imagePath: 'assets/images/scenes/scene_05_partner.png',
    ),
    // 6 — BAD ENDING 1: The Killer Escapes
    Scene(
      storyText:
          "You confront the suspect aggressively without enough concrete "
          "evidence or backup. Panicking, they shove past you, bolting out the "
          "front door into the stormy night. The killer has escaped. "
          "YOU FAILED.",
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/ending_06_escape.png',
      isEnding: true,
      endingLabel: 'The Killer Escapes — Bad Ending',
    ),
    // 7 — GOOD ENDING 1: Confession
    Scene(
      storyText:
          "Patience pays off. You hide the new will. When the police arrive, "
          "you present the motive. The Partner breaks down and confesses to "
          "the crime out of greed. YOU SOLVED THE CASE!",
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/ending_07_confession.png',
      isEnding: true,
      endingLabel: 'Justice Served — Good Ending',
    ),
    // 8 — NEUTRAL ENDING: Wrong Suspect
    Scene(
      storyText:
          "You arrest the Maid based on the torn fabric. The police "
          "congratulate you, but as you leave, you see the Partner smiling "
          "wickedly. The case is closed, but you arrested the wrong person.",
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/ending_08_wrong.png',
      isEnding: true,
      endingLabel: 'Wrong Hands Cuffed — Neutral Ending',
    ),
    // 9 — GOOD ENDING 2: Caught on Camera
    Scene(
      storyText:
          "The security camera logs show the Business Partner sneaking out of "
          "the study at exactly midnight! Combined with the Maid's innocence, "
          "you corner him trying to pack his bags. YOU CAUGHT THE KILLER!",
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/ending_09_caught.png',
      isEnding: true,
      endingLabel: 'Caught Red-Handed — Good Ending',
    ),
    // 10 — BAD ENDING 2: Trapped
    Scene(
      storyText:
          "You walk down into the pitch-black cellar alone. Suddenly, the "
          "heavy wooden door slams shut above you, and the lock clicks. You "
          "are trapped by the killer! YOU FAILED.",
      choices: [],
      nextScenes: [],
      imagePath: 'assets/images/scenes/ending_10_trapped.png',
      isEnding: true,
      endingLabel: 'Trapped in the Dark — Bad Ending',
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
