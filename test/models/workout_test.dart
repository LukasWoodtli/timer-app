import 'package:flutter_test/flutter_test.dart';
import 'package:interval_timer/src/models/interval_phase.dart';
import 'package:interval_timer/src/models/workout.dart';

final _uuidV4 = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

IntervalPhase _phase(PhaseType type, int seconds) => IntervalPhase(
  type: type,
  duration: Duration(seconds: seconds),
);

final IntervalPhase _warmup = _phase(PhaseType.warmup, 60);
final IntervalPhase _work = _phase(PhaseType.work, 30);
final IntervalPhase _rest = _phase(PhaseType.rest, 10);
final IntervalPhase _cooldown = _phase(PhaseType.cooldown, 60);

void main() {
  group('Workout', () {
    test('keeps the order of its phases', () {
      final workout = Workout(
        name: 'Tabata',
        phases: [_warmup, _work, _rest, _cooldown],
      );

      expect(workout.phases, [_warmup, _work, _rest, _cooldown]);
    });

    test('rejects an empty phase list', () {
      expect(
        () => Workout(name: 'Empty', phases: const []),
        throwsArgumentError,
      );
    });

    test('rejects an empty phase list in copyWith', () {
      final workout = Workout(name: 'Tabata', phases: [_work]);

      expect(() => workout.copyWith(phases: []), throwsArgumentError);
    });

    test('gets a unique version 4 UUID when no id is given', () {
      final first = Workout(name: 'A', phases: [_work]);
      final second = Workout(name: 'B', phases: [_work]);

      expect(first.id, matches(_uuidV4));
      expect(second.id, matches(_uuidV4));
      expect(first.id, isNot(second.id));
    });

    test('keeps a given id', () {
      final workout = Workout(id: 'abc', name: 'A', phases: [_work]);

      expect(workout.id, 'abc');
    });

    test('copies with a new name and leaves the original unchanged', () {
      final original = Workout(name: 'Old', phases: [_work, _rest]);

      final copy = original.copyWith(name: 'New');

      expect(copy.name, 'New');
      expect(copy.id, original.id);
      expect(copy.phases, original.phases);
      expect(original.name, 'Old');
    });

    test('is equal to a workout with equal fields', () {
      Workout tabata() => Workout(id: 'abc', name: 'Tabata', phases: [_work]);

      expect(tabata(), tabata());
      expect(tabata().hashCode, tabata().hashCode);
    });

    test('does not allow changes to its phase list', () {
      final workout = Workout(name: 'Tabata', phases: [_work]);

      expect(() => workout.phases.add(_rest), throwsUnsupportedError);
    });

    test('converts to JSON and back', () {
      final workout = Workout(name: 'Tabata', phases: [_warmup, _work, _rest]);

      final json = workout.toJson();

      expect(json.keys, unorderedEquals(['id', 'name', 'phases']));
      expect(Workout.fromJson(json), workout);
    });

    test('rejects JSON without a name', () {
      expect(
        () => Workout.fromJson({'id': 'abc', 'phases': <Object?>[]}),
        throwsA(anything),
      );
    });

    test('rejects JSON with a zero phase duration', () {
      expect(
        () => Workout.fromJson({
          'id': 'abc',
          'name': 'Tabata',
          'phases': [
            {'type': 'work', 'durationSeconds': 0, 'label': null},
          ],
        }),
        throwsArgumentError,
      );
    });
  });
}
