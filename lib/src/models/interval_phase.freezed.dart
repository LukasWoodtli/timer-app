// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interval_phase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntervalPhase {


/// Create a copy of IntervalPhase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntervalPhaseCopyWith<IntervalPhase> get copyWith => _$IntervalPhaseCopyWithImpl<IntervalPhase>(this as IntervalPhase, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as IntervalPhase;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntervalPhase&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as IntervalPhase;
  return Object.hash(runtimeType,_this.type,_this.duration,_this.label);
}

@override
String toString() {
  final _this = this as IntervalPhase;
  return 'IntervalPhase(type: ${_this.type}, duration: ${_this.duration}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $IntervalPhaseCopyWith<$Res>  {
  factory $IntervalPhaseCopyWith(IntervalPhase value, $Res Function(IntervalPhase) _then) = _$IntervalPhaseCopyWithImpl;
@useResult
$Res call({
 PhaseType type, Duration duration, String? label
});




}
/// @nodoc
class _$IntervalPhaseCopyWithImpl<$Res>
    implements $IntervalPhaseCopyWith<$Res> {
  _$IntervalPhaseCopyWithImpl(this._self, this._then);

  final IntervalPhase _self;
  final $Res Function(IntervalPhase) _then;

/// Create a copy of IntervalPhase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? duration = null,Object? label = freezed,}) {
  return _then(IntervalPhase(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PhaseType,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntervalPhase].
extension IntervalPhasePatterns on IntervalPhase {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
