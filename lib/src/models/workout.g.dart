// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
  name: json['name'] as String,
  phases: (json['phases'] as List<dynamic>)
      .map((e) => IntervalPhase.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: json['id'] as String?,
);

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phases': instance.phases.map((e) => e.toJson()).toList(),
};
