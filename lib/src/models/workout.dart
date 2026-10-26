import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:interval_timer/src/models/interval_phase.dart';
import 'package:uuid/uuid.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

/// A named, ordered list of interval phases.
@freezed
@JsonSerializable(explicitToJson: true)
class Workout with _$Workout {
  /// Creates a workout.
  ///
  /// Uses a random UUID if [id] is null. Throws an [ArgumentError] if
  /// [phases] is empty.
  new({required this.name, required List<IntervalPhase> phases, String? id})
    : id = id ?? const Uuid().v4(),
      phases = List.unmodifiable(phases) {
    if (phases.isEmpty) {
      throw ArgumentError.value(phases, 'phases', 'must not be empty');
    }
  }

  /// Creates a workout from JSON.
  factory fromJson(Map<String, Object?> json) => _$WorkoutFromJson(json);

  /// The unique id of this workout.
  final String id;

  /// The name of this workout.
  final String name;

  /// The phases in the order in which they run.
  final List<IntervalPhase> phases;

  /// Converts this workout to JSON.
  Map<String, Object?> toJson() => _$WorkoutToJson(this);
}
