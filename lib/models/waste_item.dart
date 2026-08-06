class WasteItem {
  const WasteItem({
    required this.name,
    required this.category,
    required this.disposalTip,
    this.confidence = 0,
  });

  final String name;
  final String category;
  final String disposalTip;
  final double confidence;
}
