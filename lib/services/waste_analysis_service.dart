
import 'package:aaclean_ai/models/waste_analysis_result.dart';

class BackendNotConfiguredException implements Exception {
  final String message;
  BackendNotConfiguredException([this.message = 'AI analĂ˝za eĹˇte nie je pripojenĂˇ.']);

  @override
  String toString() => message;
}

class WasteAnalysisService {
  final String? backendUrl;

  WasteAnalysisService({this.backendUrl});

  /// Analyze the image at [imagePath] and return a WasteAnalysisResult.
  ///
  /// If [backendUrl] is not set, a [BackendNotConfiguredException] is thrown.
  /// This method currently simulates a response; replace the simulation with
  /// a real HTTP request to your backend when available. Do NOT embed API
  /// keys directly in the application source.
  Future<WasteAnalysisResult> analyzeImage(String imagePath) async {
    if (backendUrl == null || backendUrl!.isEmpty) {
      throw BackendNotConfiguredException();
    }

    // Simulate network latency
    await Future.delayed(const Duration(seconds: 2));

    // Simulated backend JSON response â€” replace with real HTTP call.
    final Map<String, dynamic> simulatedResponse = {
      'itemName': 'Simulated item',
      'material': 'Plastic',
      'container': 'Blue recycling',
      'confidence': 0.92,
      'explanation': 'This is a simulated explanation about how to dispose of the item.',
      'needsClarification': false,
      'clarificationQuestion': null,
    };

    return WasteAnalysisResult.fromJson(simulatedResponse);
  }
}
