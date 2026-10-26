# Proposal

## Why

The timer engine (Phase 3) and persistence (Phase 5) need typed data to work on, but `lib/src/models/` is empty. We define the core models first, so later changes build on one stable, tested shape.

## What Changes

- Add an immutable `IntervalPhase` with a type (`warmup`, `work`, `rest`, `cooldown`), a duration, and an optional label.
- Add an immutable `Workout` with an id, a name, and an ordered list of phases.
- Add an immutable `WorkoutSession` that records one run of a workout: id, workout id, start time, and an optional end time.
- Give all models value equality, `copyWith`, and JSON round-trip support.
- Add the dependencies `freezed`, `freezed_annotation`, `json_annotation`, `json_serializable`, `build_runner`, and `uuid`.
- Add unit tests that cover all serialization code.

Out of scope: live timer state (Phase 3), storage (Phase 5), and any UI.

## Capabilities

### New Capabilities

- `workouts`: The definition of a workout as an ordered list of interval phases, and how it converts to and from JSON.
- `workout-sessions`: The record of one run of a workout, and how it converts to and from JSON.

### Modified Capabilities

None.

## Impact

- New code in `lib/src/models/` and new tests in `test/models/`.
- New generated files (`*.freezed.dart`, `*.g.dart`).
- New dependencies: `freezed_annotation`, `json_annotation`, `uuid`. New dev dependencies: `freezed`, `json_serializable`, `build_runner`.
- The models are pure Dart. They do not import Flutter.
