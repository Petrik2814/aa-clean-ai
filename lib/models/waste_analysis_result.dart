class WasteAnalysisResult {
  final String itemName;
  final String material;
  final String container;
  final String? containerColor;
  final double confidence;
  final String explanation;
  final String? preparation;
  final List<String> detectedConditions;
  final bool needsClarification;
  final String? clarificationQuestion;
  final List<String> clarificationOptions;

  const WasteAnalysisResult({
    required this.itemName,
    required this.material,
    required this.container,
    this.containerColor,
    required this.confidence,
    required this.explanation,
    this.preparation,
    this.detectedConditions = const [],
    required this.needsClarification,
    this.clarificationQuestion,
    this.clarificationOptions = const [],
  });

  factory WasteAnalysisResult.fromJson(Map<String, dynamic> json) => WasteAnalysisResult(
        itemName: json['itemName'] as String? ?? json['name'] as String? ?? '',
        material: json['material'] as String? ?? '',
        container: json['container'] as String? ?? '',
        containerColor: json['containerColor'] as String?,
        confidence: (json['confidence'] is num)
            ? (json['confidence'] as num).toDouble()
            : double.tryParse(json['confidence']?.toString() ?? '') ?? 0.0,
        explanation: json['explanation'] as String? ?? '',
        preparation: json['preparation'] as String?,
        detectedConditions: (json['detectedConditions'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        needsClarification: json['needsClarification'] as bool? ?? false,
        clarificationQuestion: json['clarificationQuestion'] as String?,
        clarificationOptions: (json['clarificationOptions'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'itemName': itemName,
        'material': material,
        'container': container,
        'containerColor': containerColor,
        'confidence': confidence,
        'explanation': explanation,
        'preparation': preparation,
        'detectedConditions': detectedConditions,
        'needsClarification': needsClarification,
        'clarificationQuestion': clarificationQuestion,
        'clarificationOptions': clarificationOptions,
      };
}
