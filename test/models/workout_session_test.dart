import 'package:flutter_test/flutter_test.dart';
import 'package:interval_timer/src/models/workout_session.dart';

final RegExp _uuidV4 = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

final DateTime _start = DateTime.utc(2026, 10, 26, 8);

void main() {
  group('WorkoutSession', () {
    test('records a started run that is not complete', () {
      final session = WorkoutSession(workoutId: 'w1', startedAt: _start);

      expect(session.workoutId, 'w1');
      expect(session.startedAt, _start);
      expect(session.completedAt, isNull);
      expect(session.isComplete, isFalse);
    });

    test('is complete when it has an end time', () {
      final session = WorkoutSession(
        workoutId: 'w1',
        startedAt: _start,
        completedAt: _start.add(const Duration(minutes: 20)),
      );

      expect(session.isComplete, isTrue);
    });

    test('rejects an end time before the start time', () {
      expect(
        () => WorkoutSession(
          workoutId: 'w1',
          startedAt: _start,
          completedAt: _start.subtract(const Duration(seconds: 1)),
        ),
        throwsArgumentError,
      );
    });

    test('accepts an end time equal to the start time', () {
      final session = WorkoutSession(
        workoutId: 'w1',
        startedAt: _start,
        completedAt: _start,
      );

      expect(session.completedAt, _start);
    });

    test('stores a local start time in UTC', () {
      final local = DateTime(2026, 10, 26, 8);

      final session = WorkoutSession(workoutId: 'w1', startedAt: local);

      expect(session.startedAt.isUtc, isTrue);
      expect(session.startedAt.isAtSameMomentAs(local), isTrue);
    });

    test('stores a local end time in UTC', () {
      final local = DateTime(2026, 10, 26, 9);

      final session = WorkoutSession(
        workoutId: 'w1',
        startedAt: _start.subtract(const Duration(days: 1)),
        completedAt: local,
      );

      expect(session.completedAt!.isUtc, isTrue);
      expect(session.completedAt!.isAtSameMomentAs(local), isTrue);
    });

    test('gets a unique version 4 UUID when no id is given', () {
      final first = WorkoutSession(workoutId: 'w1', startedAt: _start);
      final second = WorkoutSession(workoutId: 'w1', startedAt: _start);

      expect(first.id, matches(_uuidV4));
      expect(second.id, matches(_uuidV4));
      expect(first.id, isNot(second.id));
    });

    test('completes by copy and leaves the original unchanged', () {
      final original = WorkoutSession(workoutId: 'w1', startedAt: _start);

      final copy = original.copyWith(completedAt: _start);

      expect(copy.isComplete, isTrue);
      expect(copy.id, original.id);
      expect(original.isComplete, isFalse);
    });

    test('is equal to a session with equal fields', () {
      WorkoutSession session() =>
          WorkoutSession(id: 's1', workoutId: 'w1', startedAt: _start);

      expect(session(), session());
      expect(session().hashCode, session().hashCode);
    });

    test('converts to JSON and back', () {
      final session = WorkoutSession(
        workoutId: 'w1',
        startedAt: _start,
        completedAt: _start.add(const Duration(minutes: 20)),
      );

      expect(WorkoutSession.fromJson(session.toJson()), session);
    });

    test('converts a started session to the specified JSON shape', () {
      final session = WorkoutSession(
        id: 's1',
        workoutId: 'w1',
        startedAt: _start,
      );

      expect(session.toJson(), {
        'id': 's1',
        'workoutId': 'w1',
        'startedAt': '2026-10-26T08:00:00.000Z',
        'completedAt': null,
      });
    });

    test('rejects JSON without a workout id', () {
      expect(
        () => WorkoutSession.fromJson({
          'id': 's1',
          'startedAt': '2026-10-26T08:00:00.000Z',
          'completedAt': null,
        }),
        throwsA(anything),
      );
    });

    test('rejects JSON with an invalid time', () {
      expect(
        () => WorkoutSession.fromJson({
          'id': 's1',
          'workoutId': 'w1',
          'startedAt': 'yesterday',
          'completedAt': null,
        }),
        throwsA(anything),
      );
    });

    test('rejects JSON with an end time before the start time', () {
      expect(
        () => WorkoutSession.fromJson({
          'id': 's1',
          'workoutId': 'w1',
          'startedAt': '2026-10-26T08:00:00.000Z',
          'completedAt': '2026-10-26T07:59:59.000Z',
        }),
        throwsArgumentError,
      );
    });
  });
}
