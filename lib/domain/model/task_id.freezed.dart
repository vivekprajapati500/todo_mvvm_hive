
part of 'task_id.dart';

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.');

/// @nodoc
mixin _$TaskId {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskIdCopyWith<TaskId> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskIdCopyWith<$Res> {
  factory $TaskIdCopyWith(TaskId value, $Res Function(TaskId) then) =
      _$TaskIdCopyWithImpl<$Res, TaskId>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$TaskIdCopyWithImpl<$Res, $Val extends TaskId>
    implements $TaskIdCopyWith<$Res> {
  _$TaskIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskIdImplCopyWith<$Res> implements $TaskIdCopyWith<$Res> {
  factory _$$TaskIdImplCopyWith(
          _$TaskIdImpl value, $Res Function(_$TaskIdImpl) then) =
      __$$TaskIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$TaskIdImplCopyWithImpl<$Res>
    extends _$TaskIdCopyWithImpl<$Res, _$TaskIdImpl>
    implements _$$TaskIdImplCopyWith<$Res> {
  __$$TaskIdImplCopyWithImpl(
      _$TaskIdImpl _value, $Res Function(_$TaskIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$TaskIdImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TaskIdImpl implements _TaskId {
  const _$TaskIdImpl({required this.value});

  @override
  final int value;

  @override
  String toString() {
    return 'TaskId(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskIdImplCopyWith<_$TaskIdImpl> get copyWith =>
      __$$TaskIdImplCopyWithImpl<_$TaskIdImpl>(this, _$identity);
}

abstract class _TaskId implements TaskId {
  const factory _TaskId({required final int value}) = _$TaskIdImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$TaskIdImplCopyWith<_$TaskIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
