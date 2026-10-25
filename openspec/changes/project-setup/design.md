# Design

## Context

The repository holds only the roadmap file and the OpenSpec setup. No Flutter project exists. The Flutter SDK is not installed in the current sandbox, so project creation and checks must run where Flutter is available. The app targets iOS first. Linux, macOS, and web targets exist so that tests can run on them.

## Goals / Non-Goals

**Goals:**
- One command, `flutter analyze && flutter test`, gives the same result locally, in the Git hook, and in CI.
- The folder layout `lib/src/{models,services,repositories,controllers,ui}` exists from the start.

**Non-Goals:**
- No domain code, no timer logic, no screens. The generated counter demo is replaced by a minimal app shell.
- No Android target. Linux, macOS, and web exist for testing only, not for release.
- No release or signing setup.

## Decisions

**Create the project in the repository root with `flutter create --platforms=ios,linux,macos,web --project-name interval_timer .`.** The repository is the app, so a sub-folder only adds a path level. The name `interval_timer` follows the roadmap title and is a safe Dart package name. Alternative: a sub-folder, which suits monorepos, but we do not need one.

**Use `very_good_analysis` through `include:` in `analysis_options.yaml`.** It is the lint set the roadmap names, and it needs no custom rule list. Alternative: `flutter_lints`, which is less strict and does not meet the roadmap quality bar.

**Skip `dart_code_metrics`.** The roadmap lists it, but the proposal does not, and the package is no longer maintained under that name. If we need a metrics tool, a later change adds one.

**Use a plain Git hook in `.githooks/pre-commit` and set `core.hooksPath`.** It needs no extra tool, and the file is versioned. Alternatives: `lefthook` or the `pre-commit` framework, which add a tool for one command. The tasks include a one-line setup step in the README, because Git does not enable `core.hooksPath` on clone.

**CI runs on `ubuntu-latest` (Linux) and `macos-latest` (macOS) with `subosito/flutter-action`, pinned to a Flutter version.** Both jobs run `flutter analyze` and `flutter test`. A separate web job runs `flutter test --platform chrome`. A pinned version keeps builds repeatable. We pin GitHub Actions to full commit hashes and run `zizmor` on the workflow, as the project rules require.

## Risks / Trade-offs

- [Flutter is not installed in the sandbox] → Run the apply step where Flutter exists, or install the SDK first and ask before doing so.
- [Strict lint fails on generated code] → Fix the generated shell now, so the bar starts at zero warnings.
- [Hook can be skipped with `--no-verify`] → CI runs the same checks, so a skipped hook still fails the pull request.
- [Pinned Flutter version ages] → Update the pin in a small, separate change.
