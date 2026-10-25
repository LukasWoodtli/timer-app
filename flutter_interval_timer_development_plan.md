# Flutter Interval Timer (iOS-First) — Development Plan

This document outlines the end-to-end engineering roadmap, core execution workflow, and phase-by-phase execution plan for building a high-precision, production-grade Flutter Interval Timer application targeting iOS.

---

## 🔄 Universal Phase Execution Workflow

To maintain architectural integrity, high test coverage, and strict code quality across all stages of development, every phase in this project follows a standardized 5-step lifecycle:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│ 1. Requirements │ ──> │ 2. Implementation│ ──> │ 3. Automated    │ ──> │ 4. Manual / OS  │ ──> │ 5. Verification │
│    & Spec       │     │    & Refactoring│     │    Verification │     │    Validation   │     │    & DoD Sign-off│
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘
```

### Workflow Steps & Standards

1. **Requirements & Spec Review**:
   - Verify prerequisites from preceding phases are met.
   - Define exact interface boundaries, data models, and state transitions before writing feature code.

2. **Implementation & Refactoring**:
   - Write clean, production-ready Dart/Flutter code adhering to `very_good_analysis` standards.
   - Maintain separation of concerns (UI layers must never handle pure timer/business logic).

3. **Automated Verification Execution**:
   - Execute localized and system-wide automated testing suites.
   - Standard Verification Command:
     ```bash
     flutter analyze && flutter test --coverage
     ```

4. **Manual & OS-Level Validation**:
   - Validate features requiring physical hardware capabilities (e.g., Apple Taptic Engine, Audio Session routing, background suspension, lock-screen interactions).

5. **Definition of Done (DoD) Sign-Off**:
   - Confirm code passes CI/CD pipeline, zero lint warnings/errors remain, and test coverage metrics are met before merging into the main branch.

---

## 🛠️ Phase 1–5: Foundation & Core Engine

| Phase | Name | Goal | Prerequisites | Key Tasks | Deliverables / Definition of Done (DoD) | Tools & Technologies | Verification Commands & Tools | Notes & Risks |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **1** | **Project Setup** | Initialize Project | *None* | • Create Flutter project structure (`lib/src/{models,services,repositories,controllers,ui}`)<br>• Configure strict `analysis_options.yaml`<br>• Install foundational dependencies<br>• Setup Git hooks and GitHub Actions workflow | Clean Flutter project builds successfully in CI with zero lint warnings and standardized folder architecture. | Flutter SDK, `flutter_riverpod`, `very_good_analysis`, `dart_code_metrics`, GitHub Actions | `flutter analyze`<br>`flutter test`<br>`git status` | Set strict quality bar before any business logic is written. |
| **2** | **Domain Model** | Create Core Models | Phase 1 | • Define immutable `Workout`, `WorkoutSession`, and `IntervalPhase` entities<br>• Implement `freezed` / `json_serializable` code generation<br>• Add value equality and copy-with capabilities | Fully typed, immutable domain model with 100% serialization unit test coverage. | Dart, `freezed`, `json_annotation`, `json_serializable`, `uuid` | `dart run build_runner build --delete-conflicting-outputs`<br>`flutter test test/models/` | Domain models must remain pure Dart with zero dependencies on `flutter/material.dart`. |
| **3** | **Timer Engine** | Build State Machine | Phase 2 | • Implement deterministic interval timer state machine<br>• Derive remaining duration using `DateTime` target timestamps<br>• Implement state transitions: Start, Pause, Resume, Skip, Reset, Complete | Pure Dart timer engine running independent of the UI with precision timestamp math. | Dart `Timer`, `DateTime`, `Stopwatch` | `flutter test test/engine/` | Avoid decrementing counter ticks (`counter--`) to eliminate drift caused by OS thread scheduling. |
| **4** | **State Management** | Connect Engine to UI | Phase 3 | • Create Riverpod `Notifier` / `AsyncNotifier` controllers<br>• Expose reactive timer stream to state providers<br>• Bind lifecycle state changes to controller events | Clean separation where timer state is reactively accessible throughout the widget tree. | `flutter_riverpod`, `riverpod_annotation` | `flutter test test/providers/`<br>`flutter analyze` | Widgets must strictly consume state; logic resides entirely in controllers/notifiers. |
| **5** | **Persistence** | Save Workouts & Sessions | Phase 4 | • Build `WorkoutRepository`, `SessionRepository`, and `SettingsRepository`<br>• Implement local serialization and storage mechanism<br>• Support active session state hydration on startup | Workouts, application settings, and active workout states survive cold app restarts. | `shared_preferences`, `hive` / `isar` | `flutter test test/repositories/`<br>Manual app force-quit & relaunch validation | Abstract storage behind generic interface boundaries so underlying engine can be swapped seamlessly. |

---

## 📱 Phase 6–10: Core Application & iOS Platform Integration

| Phase | Name | Goal | Prerequisites | Key Tasks | Deliverables / Definition of Done (DoD) | Tools & Technologies | Verification Commands & Tools | Notes & Risks |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **6** | **Basic UI** | Build Core Screens | Phase 5 | • Build Home Dashboard, Workout Builder, Active Timer view, and Settings screen<br>• Add form input validation for interval durations<br>• Implement basic route navigation | Functional MVP UI allowing full creation, editing, and execution of interval workouts. | Flutter Material/Cupertino Widgets, `go_router` | `flutter test test/ui/`<br>`flutter run` | Prioritize responsive layout correctness and form validation over heavy visual polish. |
| **7** | **Audio & Haptics** | Workout Feedback | Phase 6 | • Create `AudioService` and `HapticsService`<br>• Preload audio cues into memory for phase transitions<br>• Implement Apple Taptic Engine feedback pattern triggers | Clear auditory audio cues and tactile haptic alerts fire reliably on interval state shifts. | `audioplayers`, `services/haptic_feedback.dart` | Manual testing on physical iPhone (`flutter run -d <device_id>`) | iOS Simulators do NOT support Taptic Engine haptics or true Audio Session behaviors; physical iPhone required. |
| **8** | **Backgrounding** | Notifications & Recovery | Phase 7 | • Schedule precise local notifications for upcoming phase changes<br>• Handle app state transitions (`paused`, `resumed`)<br>• Cancel/reschedule notification queues on pause/resume | Accurate local notifications trigger while app is backgrounded or locked; state syncs on return. | `flutter_local_notifications`, `permission_handler` | Manual lock-screen validation<br>Low Power Mode verification | iOS strictly limits background execution. Notifications are scheduled alerts, NOT execution drivers. |
| **9** | **Lifecycle** | Session Recovery | Phase 8 | • Persist session state snapshot when app is backgrounded/killed<br>• Recalculate elapsed time from epoch timestamps upon restore<br>• Gracefully handle incoming phone call/Siri interruptions | Active workouts resume seamlessly with accurate elapsed time after OS suspension or force-close. | Flutter `AppLifecycleListener` / `WidgetsBindingObserver` | Manual interruption testing (incoming calls, alarm clocks, background termination) | Target time calculation must always derive from target timestamps, never elapsed tick counters. |
| **10** | **Polish** | Visual Improvements | Phase 9 | • Build smooth circular progress indicator with `CustomPainter`<br>• Implement dynamic color shifts based on interval state (Work/Rest)<br>• Integrate awake lock feature to prevent screen dimming | Polished, fluid user interface with high-framerate custom rendering and dynamic visual state. | `wakelock_plus`, `CustomPainter`, `flutter_animate` | `flutter run --profile`<br>Flutter DevTools Performance Overlay | UI animations must be driven by timer state, never drive or alter timer engine state. |

---

## 🚀 Phase 11–14: Quality Assurance, Release & iOS Enhancements

| Phase | Name | Goal | Prerequisites | Key Tasks | Deliverables / Definition of Done (DoD) | Tools & Technologies | Verification Commands & Tools | Notes & Risks |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **11** | **Testing** | Comprehensive QA | Phase 10 | • Expand unit test suite for core state machine<br>• Add integration tests for key user journeys<br>• Conduct memory leak and frame drop profiling | High code coverage across core business logic; verified zero memory leaks or UI jank. | `integration_test`, Flutter DevTools, `coverage` | `flutter test --coverage`<br>`flutter drive --target=test_driver/app.dart` | Aim for high unit test coverage on timer engine and repositories rather than 100% UI layout coverage. |
| **12** | **Beta** | TestFlight Release | Phase 11 | • Configure App Store Connect app entry and provisioning profiles<br>• Build release `.ipa` archive<br>• Distribute build to internal and external TestFlight groups | Validated build available on TestFlight with crash reporting active. | Xcode, App Store Connect, TestFlight | `flutter build ipa --release`<br>Xcode Organizer submission | Validate audio session behaviors during active telephone calls and background audio playback (e.g., Spotify). |
| **13** | **Release** | App Store Launch | Phase 12 | • Finalize store graphics, screenshots, privacy labels, and metadata<br>• Conduct final production build regression check<br>• Submit application for Apple App Store review | Public application live on the iOS App Store. | App Store Connect | Final sanity verification on release build target | Apple App Privacy questionnaire must accurately reflect that zero user data/analytics are transmitted off-device. |
| **14** | **iOS Extras** | Native Enhancements | Phase 13 | • Implement Live Activities via iOS ActivityKit<br>• Build dynamic Lock Screen and Dynamic Island timer widgets<br>• (Optional) Apple Watch / HealthKit workout integration | Live dynamic updates on Lock Screen and Dynamic Island during active workouts. | Swift, `WidgetKit`, `ActivityKit`, `home_widget` | Manual verification on physical iOS 16.1+ device | Implement incrementally after the core MVP application is completely published and stabilized. |
