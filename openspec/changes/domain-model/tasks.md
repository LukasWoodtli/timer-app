# Tasks

## 1. Dependencies and analyzer

- [x] 1.1 Add `freezed_annotation`, `json_annotation`, and `uuid` as dependencies, and `freezed`, `json_serializable`, and `build_runner` as dev dependencies. Verify that `flutter pub get` succeeds.
- [x] 1.2 Add `**/*.freezed.dart` and `**/*.g.dart` to `analyzer.exclude` in `analysis_options.yaml`. Verify that `flutter analyze` reports zero issues.
- [x] 1.3 Write a throwaway model with a freezed plain-class constructor that has a body and `fromJson`. Run `build_runner`. Verify that the generated code compiles, then delete the throwaway model. If it fails, stop and ask before you change the approach.

## 2. Interval phase

- [x] 2.1 Write failing tests in `test/models/interval_phase_test.dart` for every `IntervalPhase` scenario in `specs/workouts/spec.md`. Verify that `flutter test test/models/` fails.
- [x] 2.2 Add `PhaseType`, the `durationSeconds` converter, and `IntervalPhase` in `lib/src/models/interval_phase.dart`, and run `dart run build_runner build --delete-conflicting-outputs`. Verify that the tests from 2.1 pass.

## 3. Workout

- [x] 3.1 Write failing tests in `test/models/workout_test.dart` for every `Workout` scenario in `specs/workouts/spec.md`. Verify that `flutter test test/models/` fails.
- [x] 3.2 Add `Workout` in `lib/src/models/workout.dart` and run `build_runner`. Verify that the tests from 3.1 pass.

## 4. Workout session

- [x] 4.1 Write failing tests in `test/models/workout_session_test.dart` for every scenario in `specs/workout-sessions/spec.md`. Verify that `flutter test test/models/` fails.
- [x] 4.2 Add `WorkoutSession` in `lib/src/models/workout_session.dart` and run `build_runner`. Verify that the tests from 4.1 pass.

## 5. Integration checks

- [ ] 5.1 Add the barrel file `lib/src/models/models.dart` and remove `lib/src/models/.gitkeep`. Verify that `flutter analyze` reports zero issues.
- [ ] 5.2 Run `flutter test --coverage`. Verify that `coverage/lcov.info` shows 100% line coverage for the three handwritten model files.
- [ ] 5.3 Search `lib/src/models/` for `package:flutter`. Verify that there are no matches.
- [ ] 5.4 Run the pre-commit hook (`.githooks/pre-commit`). Verify that it passes with the generated files committed.

## Workflow follow-up

- Archive the change after review.
