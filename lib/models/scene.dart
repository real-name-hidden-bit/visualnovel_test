
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
