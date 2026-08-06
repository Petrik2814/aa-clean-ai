import '../models/waste_item.dart';

class AiService {
  /// Identifies waste based on an image file path.
  /// In a real app, this would send the image to a backend or use an on-device model.
  Future<WasteItem> identifyWaste(String imagePath) async {
    // Simulating network/processing delay
    await Future.delayed(const Duration(seconds: 2));

    return const WasteItem(
      name: 'Plastic bottle',
      category: 'Plastic',
      disposalTip: 'Empty and place in plastic recycling.',
      confidence: .92,
    );
  }
}
