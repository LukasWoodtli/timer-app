# Tasks

## 1. Flutter project

- [x] 1.1 Make sure that Flutter is installed, then run `flutter create --platforms=ios,linux,macos,web --project-name interval_timer .` in the repository root. Verify that `flutter analyze` runs.
- [x] 1.2 Create the folders `lib/src/{models,services,repositories,controllers,ui}` with a `.gitkeep` file in each. Verify that all five folders exist.
- [x] 1.3 Replace the generated counter demo with a minimal app shell in `lib/main.dart` and update the generated widget test to match. Verify that `flutter test` passes.

## 2. Dependencies and lint

- [x] 2.1 Add `flutter_riverpod` as a dependency and `very_good_analysis` as a dev dependency. Verify that `flutter pub get` succeeds.
- [x] 2.2 Set `include: package:very_good_analysis/analysis_options.yaml` in `analysis_options.yaml`. Verify that `flutter analyze` reports zero issues.

## 3. Git hook

- [x] 3.1 Add `.githooks/pre-commit` that runs `flutter analyze && flutter test`. Verify that a commit with a lint error fails.
- [x] 3.2 Add a README section that tells contributors to run `git config core.hooksPath .githooks`. Verify that the documented command enables the hook.

## 4. CI

- [ ] 4.1 Add `.github/workflows/ci.yml` that runs `flutter analyze` and `flutter test` on `ubuntu-latest` and `macos-latest` (each followed by `flutter build linux` or `flutter build macos`, with the GTK packages installed first on Linux), and `flutter test --platform chrome` for web, with a pinned Flutter version and actions pinned to commit hashes. Verify that the workflow passes on a pull request.
- [x] 4.2 Run `zizmor` on the workflow file. Verify that it reports no findings.

## Workflow follow-up

- Archive the change after review.
