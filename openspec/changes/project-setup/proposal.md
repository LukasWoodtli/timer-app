# Proposal

## Why

The repository has a roadmap but no Flutter project. Later changes (domain model, timer engine) need a project that builds, a strict lint bar, and automatic checks. We set the quality bar first, before any business logic exists.

## What Changes

- Create the Flutter project with the folders `lib/src/{models,services,repositories,controllers,ui}`.
- Add a strict `analysis_options.yaml` that uses `very_good_analysis`.
- Add the first dependencies: `flutter_riverpod` and `very_good_analysis`.
- Add a GitHub Actions workflow that runs `flutter analyze` and `flutter test`.
- Add a Git hook that runs the same checks before a commit.

## Capabilities

### New Capabilities

None. This change adds tooling and structure only. It adds no user-visible behavior.

### Modified Capabilities

None.

## Impact

- New files: Flutter project, `analysis_options.yaml`, `pubspec.yaml`, `.github/workflows/`, Git hook configuration.
- New dependencies: `flutter_riverpod`, `very_good_analysis`.
- The change has no spec delta, so `.openspec.yaml` needs `skip_specs: true` before `openspec validate` passes.
