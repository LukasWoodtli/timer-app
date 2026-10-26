import 'package:flutter_test/flutter_test.dart';
import 'package:interval_timer/src/models/interval_phase.dart';

void main() {
  group('IntervalPhase', () {
    test('holds type, duration, and label', () {
      final phase = IntervalPhase(
        type: PhaseType.work,
        duration: const Duration(seconds: 30),
        label: 'Squats',
      );

      expect(phase.type, PhaseType.work);
      expect(phase.duration, const Duration(seconds: 30));
      expect(phase.label, 'Squats');
    });

    test('has no label when none is given', () {
      final phase = IntervalPhase(
        type: PhaseType.rest,
        duration: const Duration(seconds: 10),
      );

      expect(phase.label, isNull);
    });

    test('rejects a zero duration', () {
      expect(
        () => IntervalPhase(type: PhaseType.work, duration: Duration.zero),
        throwsArgumentError,
      );
    });

    test('rejects a negative duration', () {
      expect(
        () => IntervalPhase(
          type: PhaseType.work,
          duration: const Duration(seconds: -5),
        ),
        throwsArgumentError,
      );
    });

    test('rejects a duration with a fraction of a second', () {
      expect(
        () => IntervalPhase(
          type: PhaseType.work,
          duration: const Duration(milliseconds: 1500),
        ),
        throwsArgumentError,
      );
    });

    test('rejects an invalid duration in copyWith', () {
      final phase = IntervalPhase(
        type: PhaseType.work,
        duration: const Duration(seconds: 30),
      );

      expect(
        () => phase.copyWith(duration: Duration.zero),
        throwsArgumentError,
      );
    });

    test('is equal to a phase with equal fields', () {
      IntervalPhase squats() => IntervalPhase(
        type: PhaseType.work,
        duration: const Duration(seconds: 30),
        label: 'Squats',
      );

      expect(squats(), squats());
      expect(squats().hashCode, squats().hashCode);
    });

    test('converts to the specified JSON shape', () {
      final phase = IntervalPhase(
        type: PhaseType.work,
        duration: const Duration(seconds: 30),
        label: 'Squats',
      );

      expect(phase.toJson(), {
        'type': 'work',
        'durationSeconds': 30,
        'label': 'Squats',
      });
    });

    test('converts to JSON and back', () {
      final phase = IntervalPhase(
        type: PhaseType.cooldown,
        duration: const Duration(seconds: 60),
      );

      expect(IntervalPhase.fromJson(phase.toJson()), phase);
    });

    test('rejects an unknown phase type in JSON', () {
      expect(
        () => IntervalPhase.fromJson({
          'type': 'sprint',
          'durationSeconds': 30,
          'label': null,
        }),
        throwsA(anything),
      );
    });

    test('rejects a zero duration in JSON', () {
      expect(
        () => IntervalPhase.fromJson({
          'type': 'work',
          'durationSeconds': 0,
          'label': null,
        }),
        throwsArgumentError,
      );
    });
  });
}
