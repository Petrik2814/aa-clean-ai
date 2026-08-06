import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/home/home_screen.dart';
import 'screens/camera/camera_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/preview/preview_screen.dart';
import 'theme/app_theme.dart';

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
