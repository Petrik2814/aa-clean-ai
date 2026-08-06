import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

// Note: You will need to run 'flutterfire configure' to generate this file
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Uncomment the following lines after running 'flutterfire configure'
    /*
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    */

    // For now, we'll use a basic initialization if possible, or just skip
    // if options aren't present to avoid crashing on startup.
    // await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  runApp(
    const ProviderScope(
      child: AACleanAI(),
    ),
  );
}
