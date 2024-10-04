// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_room_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateRoomViewState {
  DateTime? get roomStartDate => throw _privateConstructorUsedError;
  DateTime? get roomEndDate => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of CreateRoomViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateRoomViewStateCopyWith<CreateRoomViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateRoomViewStateCopyWith<$Res> {
  factory $CreateRoomViewStateCopyWith(
          CreateRoomViewState value, $Res Function(CreateRoomViewState) then) =
      _$CreateRoomViewStateCopyWithImpl<$Res, CreateRoomViewState>;
  @useResult
  $Res call({DateTime? roomStartDate, DateTime? roomEndDate, String? imageUrl});
}

/// @nodoc
class _$CreateRoomViewStateCopyWithImpl<$Res, $Val extends CreateRoomViewState>
    implements $CreateRoomViewStateCopyWith<$Res> {
  _$CreateRoomViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateRoomViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomStartDate = freezed,
    Object? roomEndDate = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      roomStartDate: freezed == roomStartDate
          ? _value.roomStartDate
          : roomStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      roomEndDate: freezed == roomEndDate
          ? _value.roomEndDate
          : roomEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateRoomViewStateImplCopyWith<$Res>
    implements $CreateRoomViewStateCopyWith<$Res> {
  factory _$$CreateRoomViewStateImplCopyWith(_$CreateRoomViewStateImpl value,
          $Res Function(_$CreateRoomViewStateImpl) then) =
      __$$CreateRoomViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? roomStartDate, DateTime? roomEndDate, String? imageUrl});
}

/// @nodoc
class __$$CreateRoomViewStateImplCopyWithImpl<$Res>
    extends _$CreateRoomViewStateCopyWithImpl<$Res, _$CreateRoomViewStateImpl>
    implements _$$CreateRoomViewStateImplCopyWith<$Res> {
  __$$CreateRoomViewStateImplCopyWithImpl(_$CreateRoomViewStateImpl _value,
      $Res Function(_$CreateRoomViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateRoomViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomStartDate = freezed,
    Object? roomEndDate = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$CreateRoomViewStateImpl(
      roomStartDate: freezed == roomStartDate
          ? _value.roomStartDate
          : roomStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      roomEndDate: freezed == roomEndDate
          ? _value.roomEndDate
          : roomEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CreateRoomViewStateImpl implements _CreateRoomViewState {
  _$CreateRoomViewStateImpl(
      {this.roomStartDate, this.roomEndDate, this.imageUrl});

  @override
  final DateTime? roomStartDate;
  @override
  final DateTime? roomEndDate;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'CreateRoomViewState(roomStartDate: $roomStartDate, roomEndDate: $roomEndDate, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRoomViewStateImpl &&
            (identical(other.roomStartDate, roomStartDate) ||
                other.roomStartDate == roomStartDate) &&
            (identical(other.roomEndDate, roomEndDate) ||
                other.roomEndDate == roomEndDate) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, roomStartDate, roomEndDate, imageUrl);

  /// Create a copy of CreateRoomViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRoomViewStateImplCopyWith<_$CreateRoomViewStateImpl> get copyWith =>
      __$$CreateRoomViewStateImplCopyWithImpl<_$CreateRoomViewStateImpl>(
          this, _$identity);
}

abstract class _CreateRoomViewState implements CreateRoomViewState {
  factory _CreateRoomViewState(
      {final DateTime? roomStartDate,
      final DateTime? roomEndDate,
      final String? imageUrl}) = _$CreateRoomViewStateImpl;

  @override
  DateTime? get roomStartDate;
  @override
  DateTime? get roomEndDate;
  @override
  String? get imageUrl;

  /// Create a copy of CreateRoomViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateRoomViewStateImplCopyWith<_$CreateRoomViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
