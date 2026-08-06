import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

<<<<<<< HEAD
import 'screens/analyze/analyze_screen.dart';
import 'screens/analyze/result_screen.dart';
import 'screens/camera/camera_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/preview/preview_screen.dart';
import 'theme/app_theme.dart';
=======
import 'package:aaclean_ai/features/home/home_screen.dart';
import 'package:aaclean_ai/features/scanner/camera_screen.dart';
import 'package:aaclean_ai/features/ai/chat_screen.dart';
import 'package:aaclean_ai/features/scanner/preview_screen.dart';
import 'package:aaclean_ai/features/scanner/analysis_loading_screen.dart';
import 'package:aaclean_ai/features/scanner/result_screen.dart';
import 'package:aaclean_ai/theme/app_theme.dart';
>>>>>>> f85cb303dedc479847e0db666bd0ca4711707cfa

class AACleanAI extends StatelessWidget {
  const AACleanAI({super.key});

  static final GoRouter _router = GoRouter(
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
        path: '/analyze',
        builder: (context, state) {
          final imagePath = state.extra as String?;
          return AnalyzeScreen(imagePath: imagePath);
        },
      ),
      GoRoute(
        path: '/analyze/result',
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
