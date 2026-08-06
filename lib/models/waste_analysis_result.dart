class WasteAnalysisResult {
  final String itemName;
  final String material;
  final String container;
  final double confidence;
  final String explanation;
  final bool needsClarification;
  final String? clarificationQuestion;

  const WasteAnalysisResult({
    required this.itemName,
    required this.material,
    required this.container,
    required this.confidence,
    required this.explanation,
    required this.needsClarification,
    this.clarificationQuestion,
  });

  factory WasteAnalysisResult.fromJson(Map<String, dynamic> json) => WasteAnalysisResult(
        itemName: json['itemName'] as String? ?? '',
        material: json['material'] as String? ?? '',
        container: json['container'] as String? ?? '',
        confidence: (json['confidence'] is num) ? (json['confidence'] as num).toDouble() : double.tryParse(json['confidence']?.toString() ?? '') ?? 0.0,
        explanation: json['explanation'] as String? ?? '',
        needsClarification: json['needsClarification'] as bool? ?? false,
        clarificationQuestion: json['clarificationQuestion'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'itemName': itemName,
        'material': material,
        'container': container,
        'confidence': confidence,
        'explanation': explanation,
        'needsClarification': needsClarification,
        'clarificationQuestion': clarificationQuestion,
      };
}
