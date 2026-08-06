import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:aaclean_ai/features/home/home_screen.dart';
import 'package:aaclean_ai/features/scanner/camera_screen.dart';
import 'package:aaclean_ai/features/ai/chat_screen.dart';
import 'package:aaclean_ai/features/scanner/preview_screen.dart';
import 'package:aaclean_ai/features/scanner/analysis_loading_screen.dart';
import 'package:aaclean_ai/features/scanner/result_screen.dart';
import 'package:aaclean_ai/theme/app_theme.dart';

class AACleanAI extends StatelessWidget {
  const AACleanAI({super.key});

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/camera',
        builder: (context, state) => const CameraScreen(),
      ),
      GoRoute(
        path: '/preview',
        builder: (context, state) {
          final imagePath = state.extra as String?;
          return PreviewScreen(imagePath: imagePath);
        },
      ),
      GoRoute(
        path: '/analysis',
        builder: (context, state) {
          final imagePath = state.extra as String?;
          return AnalysisLoadingScreen(imagePath: imagePath);
        },
      ),
      GoRoute(
        path: '/waste-result',
        builder: (context, state) {
          final result = state.extra as Map<String, dynamic>?;
          return WasteResultScreen(result: result);
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AA CLEAN AI',
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}
