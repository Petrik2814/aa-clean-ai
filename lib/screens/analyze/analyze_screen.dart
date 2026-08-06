import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aaclean_ai/theme/app_theme.dart';

class AnalyzeScreen extends StatefulWidget {
  final String? imagePath;
  const AnalyzeScreen({super.key, this.imagePath});

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final Map<String, dynamic> testResult = {
        'name': 'Krabica od pizze',
        'material': 'Papier',
        'container': 'Modrý kontajner',
        'warning': 'Mastná časť patrí do zmesového odpadu',
        'confidence': '92 %',
        'explanation': 'Mastnota znehodnocuje papier pri recyklácii',
      };
      if (mounted) {
        context.go('/analyze/result', extra: testResult);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppTheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyzovanie'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: primary),
              const SizedBox(height: 20),
              const Text(
                'Cleany analyzuje odpad...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
