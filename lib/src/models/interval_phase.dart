import 'package:freezed_annotation/freezed_annotation.dart';

part 'interval_phase.freezed.dart';
part 'interval_phase.g.dart';

/// The kind of an interval phase.
enum PhaseType {
  /// Easy start before the main part.
  warmup,

  /// Active effort.
  work,

  /// Pause between efforts.
  rest,

  /// Easy end after the main part.
  cooldown,
}

/// Converts a [Duration] to whole seconds in JSON and back.
class DurationSecondsConverter implements JsonConverter<Duration, int> {
  /// Creates the converter.
  const new();

  @override
  Duration fromJson(int json) => Duration(seconds: json);

  @override
  int toJson(Duration object) => object.inSeconds;
}

/// One timed step of a workout.
@freezed
@JsonSerializable()
class IntervalPhase with _$IntervalPhase {
  /// Creates a phase.
  ///
  /// Throws an [ArgumentError] if [duration] is not a positive whole number
  /// of seconds.
  new({required this.type, required this.duration, this.label}) {
    _checkDuration(duration);
  }

  /// Creates a phase from JSON.
  factory fromJson(Map<String, Object?> json) => _$IntervalPhaseFromJson(json);

  /// The kind of this phase.
  final PhaseType type;

  /// How long this phase runs.
  @JsonKey(name: 'durationSeconds')
  @DurationSecondsConverter()
  final Duration duration;

  /// An optional name, for example the exercise.
  final String? label;

  /// Converts this phase to JSON.
  Map<String, Object?> toJson() => _$IntervalPhaseToJson(this);
}

void _checkDuration(Duration duration) {
  final isWholeSeconds =
      duration.inMicroseconds % Duration.microsecondsPerSecond == 0;
  if (duration <= Duration.zero || !isWholeSeconds) {
    throw ArgumentError.value(
      duration,
      'duration',
      'must be a positive whole number of seconds',
    );
  }
}
