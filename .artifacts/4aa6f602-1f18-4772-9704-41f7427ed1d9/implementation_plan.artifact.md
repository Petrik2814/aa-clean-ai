# Implementation Plan - Fixing and Structuring the Cleany App

This plan addresses the inconsistencies in the project structure, initializes Firebase, and sets up a solid foundation for the AI-assisted waste identification feature.

## Proposed Changes

### 1. Project Structure & Cleanup
- **Remove redundant files**: We have both `lib/app.dart` and `lib/src/app.dart`. I will consolidate these into a single `lib/app.dart` and update `main.dart` to import it.
- **Unify Theme**: Use the `AppTheme` defined in `lib/theme/app_theme.dart` consistently across the app.

### 2. Firebase & Core Setup
- **Initialize Firebase**: Update `lib/main.dart` to include `Firebase.initializeApp()`.
- **Firebase Options**: Note that `firebase_options.dart` is currently missing. I'll add a placeholder or instructions on how to generate it using `flutterfire configure`.

### 3. Navigation & Routing
- **Implement GoRouter**: Since `go_router` is in `pubspec.yaml`, I'll set up a central router in `lib/app.dart` to handle navigation between `HomeScreen`, `ScanScreen`, `ChatScreen`, etc.

### 4. Feature Improvements
- **Camera to AI Integration**:
    - Improve `CameraScreen` to handle errors and empty camera lists.
    - Update `HomeScreen` to navigate to a result screen after taking a photo.
    - Enhance `AiService` to accept an image path for identification.

---

## Proposed File Changes

### [Component] Core & Main
#### [MODIFY] [main.dart](file:///C:/Users/petea/OneDrive/Documents/cleany/lib/main.dart)
- Add `Firebase.initializeApp()`.
- Add `DefaultFirebaseOptions` (placeholder).

#### [MODIFY] [app.dart](file:///C:/Users/petea/OneDrive/Documents/cleany/lib/app.dart)
- Set up `GoRouter`.
- Use `AppTheme.light`.

#### [DELETE] [app.dart](file:///C:/Users/petea/OneDrive/Documents/cleany/lib/src/app.dart)
- Remove the redundant app file.

### [Component] Services & Features
#### [MODIFY] [ai_service.dart](file:///C:/Users/petea/OneDrive/Documents/cleany/lib/services/ai_service.dart)
- Update `identifyWaste` to take a `String imagePath`.

#### [MODIFY] [camera_screen.dart](file:///C:/Users/petea/OneDrive/Documents/cleany/lib/screens/camera/camera_screen.dart)
- Add safety checks for camera availability.
- Improve error handling.

## Verification Plan

### Manual Verification
- Verify that the app starts without errors (even if Firebase isn't fully configured yet, we can catch the initialization error).
- Check that navigation works between Home and Camera.
- Verify that the UI uses the blue theme from `AppTheme`.
