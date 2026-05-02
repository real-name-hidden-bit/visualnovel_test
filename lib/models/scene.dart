/// R1 — A single page/scene of the story.
///
/// Properties intentionally match the rubric:
///   - storyText: the narrative text shown to the player
///   - choices:   the buttons offered to the player
///   - nextScenes: parallel list of scene indices each choice leads to
///   - imagePath: scene image asset (R4 — one image per scene)
///   - isEnding:  true if this scene ends the story (R6)
///   - endingLabel: label shown on the end screen (e.g. "Good Ending")
class Scene {
  final String storyText;
  final List<String> choices;
  final List<int> nextScenes;
  final String imagePath;
  final bool isEnding;
  final String? endingLabel;

  const Scene({
    required this.storyText,
    required this.choices,
    required this.nextScenes,
    required this.imagePath,
    this.isEnding = false,
    this.endingLabel,
  });
}
