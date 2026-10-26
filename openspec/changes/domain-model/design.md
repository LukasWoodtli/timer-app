# Design

## Context

`lib/src/models/` is empty. The project uses `very_good_analysis`, Flutter 3.47.8, and a pre-commit hook plus CI that run `flutter analyze` and `flutter test`. Neither runs code generation. See proposal.md for the motivation and specs/ for the rules.

## Goals / Non-Goals

**Goals:**
- Each rule in the specs holds for every way to make a model: constructor, `copyWith`, and `fromJson`.
- The model files import only Dart and the packages listed in the proposal.

**Non-Goals:**
- No CI step that compares generated files with fresh `build_runner` output.
- No limits on the name of a workout or the label of a phase (Phase 6 adds form validation).

## Decisions

**Use `freezed` with plain class constructors that have a body.** Freezed 3 supports classes with a normal constructor. The constructor body checks the rules and throws `ArgumentError`. Because `copyWith` and `fromJson` call the same constructor, they cannot skip the checks. Alternative: redirecting factories with `@Assert`, but asserts do not run in release builds. During apply, make sure that the installed `freezed` version supports this syntax before writing all three models.

**Store the phase list with `List.unmodifiable`.** Freezed makes lists unmodifiable only for its factory constructors, not for plain constructors. The constructor wraps the list, so the "Phase list cannot change" scenario holds.

**Convert `Duration` with a small `JsonConverter` to `durationSeconds`.** The user chose whole seconds in JSON. The converter writes `inSeconds` and reads `Duration(seconds: n)`. The constructor rule (whole, positive seconds) makes the conversion lossless. Alternative: milliseconds, which the user did not choose.

**Generate missing ids with the `uuid` package.** The constructor takes `String? id`. If the id is null, the constructor uses `const Uuid().v4()`. `fromJson` always passes the stored id. Alternative: make the caller pass an id, which moves the same code to every call site.

**Convert session times to UTC in the constructor.** Then `toIso8601String()` writes the `Z` suffix that the spec asks for. Equality also does not depend on the time zone of the input.

**Commit the generated `*.freezed.dart` and `*.g.dart` files, and exclude them from the analyzer.** The hook and CI then work without `build_runner`. Alternative: run `build_runner` in CI and the hook, which makes every check slower. Generated code does not follow `very_good_analysis`, so `analysis_options.yaml` excludes `**/*.freezed.dart` and `**/*.g.dart`.

**Put one model per file, with an `models.dart` barrel file.** Files: `interval_phase.dart`, `workout.dart`, `workout_session.dart`. Tests mirror them in `test/models/`.

## Risks / Trade-offs

- [Generated files go stale after a model edit] → Run `dart run build_runner build --delete-conflicting-outputs` after each model edit. The analyzer reports most mismatches as errors.
- [Freezed plain-class syntax is less common and needs more code] → Keep the three models small. If the syntax does not work with the installed version, stop and ask before changing the approach.
- [Coverage of generated code is not 100%] → Measure coverage for the handwritten model files only.
