import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'workout_session.freezed.dart';
part 'workout_session.g.dart';

/// The record of one run of a workout.
@freezed
@JsonSerializable()
class WorkoutSession with _$WorkoutSession {
  /// Creates a session and stores its times in UTC.
  ///
  /// Uses a random UUID if [id] is null. Throws an [ArgumentError] if
  /// [completedAt] is before [startedAt].
  new({
    required this.workoutId,
    required DateTime startedAt,
    DateTime? completedAt,
    String? id,
  }) : id = id ?? const Uuid().v4(),
       startedAt = startedAt.toUtc(),
       completedAt = completedAt?.toUtc() {
    if (completedAt != null && completedAt.isBefore(startedAt)) {
      throw ArgumentError.value(
        completedAt,
        'completedAt',
        'must not be before startedAt',
      );
    }
  }

  /// Creates a session from JSON.
  factory fromJson(Map<String, Object?> json) => _$WorkoutSessionFromJson(json);

  /// The unique id of this session.
  final String id;

  /// The id of the workout that this session runs.
  final String workoutId;

  /// When the run started, in UTC.
  final DateTime startedAt;

  /// When the run ended, in UTC, or null if it did not end.
  final DateTime? completedAt;

  /// Whether the run ended.
  bool get isComplete => completedAt != null;

  /// Converts this session to JSON.
  Map<String, Object?> toJson() => _$WorkoutSessionToJson(this);
}
