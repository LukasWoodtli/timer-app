// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval_phase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntervalPhase _$IntervalPhaseFromJson(Map<String, dynamic> json) =>
    IntervalPhase(
      type: $enumDecode(_$PhaseTypeEnumMap, json['type']),
      duration: const DurationSecondsConverter().fromJson(
        (json['durationSeconds'] as num).toInt(),
      ),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$IntervalPhaseToJson(
  IntervalPhase instance,
) => <String, dynamic>{
  'type': _$PhaseTypeEnumMap[instance.type]!,
  'durationSeconds': const DurationSecondsConverter().toJson(instance.duration),
  'label': instance.label,
};

const _$PhaseTypeEnumMap = {
  PhaseType.warmup: 'warmup',
  PhaseType.work: 'work',
  PhaseType.rest: 'rest',
  PhaseType.cooldown: 'cooldown',
};
