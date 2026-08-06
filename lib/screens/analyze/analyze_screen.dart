import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aaclean_ai/theme/app_theme.dart';
import 'package:aaclean_ai/services/waste_analysis_service.dart';
import 'package:aaclean_ai/models/waste_analysis_result.dart';

class AnalyzeScreen extends StatefulWidget {
  final String? imagePath;
  const AnalyzeScreen({super.key, this.imagePath});

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  final WasteAnalysisService _service = WasteAnalysisService();
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  Future<void> _startAnalysis() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final imagePath = widget.imagePath;
    if (imagePath == null || imagePath.isEmpty) {
      setState(() {
        _error = 'Žiadna cesta k obrázku.';
        _isLoading = false;
      });
      return;
    }

    try {
      final WasteAnalysisResult result = await _service.analyzeImage(imagePath);
      if (!mounted) return;
      context.go('/waste-result', extra: result.toJson());
    } on BackendNotConfiguredException catch (e) {
      setState(() {
        _error = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Analyzovanie zlyhalo. Skúste znova.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppTheme.primary;
    return Scaffold(
      appBar: AppBar(title: const Text('Analyzovanie')),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: primary),
                    const SizedBox(height: 20),
                    const Text(
                      'Cleany analyzuje odpad...',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              : _error != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _startAnalysis,
                          child: const Text('Skúsiť znova'),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
