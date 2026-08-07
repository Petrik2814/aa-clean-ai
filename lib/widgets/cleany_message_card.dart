import 'package:flutter/material.dart';
import 'package:aaclean_ai/theme/app_theme.dart';

class CleanyMessageCard extends StatelessWidget {
  final String message;
  final String? subtitle;
  final Color accentColor;

  const CleanyMessageCard({
    super.key,
    required this.message,
    this.subtitle,
    this.accentColor = AppTheme.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: accentColor,
              child: const Text('🤖', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cleany', style: TextStyle(fontWeight: FontWeight.bold, color: accentColor)),
                  const SizedBox(height: 6),
                  Text(message, style: const TextStyle(fontSize: 14)),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(subtitle!, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
