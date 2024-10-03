// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Message {
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Timestamp get sentAt => throw _privateConstructorUsedError;
  bool get isMyTurn => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String userId,
      String name,
      String message,
      Timestamp sentAt,
      bool isMyTurn});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? message = null,
    Object? sentAt = null,
    Object? isMyTurn = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      isMyTurn: null == isMyTurn
          ? _value.isMyTurn
          : isMyTurn // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String name,
      String message,
      Timestamp sentAt,
      bool isMyTurn});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? message = null,
    Object? sentAt = null,
    Object? isMyTurn = null,
  }) {
    return _then(_$MessageImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      isMyTurn: null == isMyTurn
          ? _value.isMyTurn
          : isMyTurn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MessageImpl with DiagnosticableTreeMixin implements _Message {
  const _$MessageImpl(
      {required this.userId,
      required this.name,
      required this.message,
      required this.sentAt,
      required this.isMyTurn});

  @override
  final String userId;
  @override
  final String name;
  @override
  final String message;
  @override
  final Timestamp sentAt;
  @override
  final bool isMyTurn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message(userId: $userId, name: $name, message: $message, sentAt: $sentAt, isMyTurn: $isMyTurn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('sentAt', sentAt))
      ..add(DiagnosticsProperty('isMyTurn', isMyTurn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.isMyTurn, isMyTurn) ||
                other.isMyTurn == isMyTurn));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, name, message, sentAt, isMyTurn);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String userId,
      required final String name,
      required final String message,
      required final Timestamp sentAt,
      required final bool isMyTurn}) = _$MessageImpl;

  @override
  String get userId;
  @override
  String get name;
  @override
  String get message;
  @override
  Timestamp get sentAt;
  @override
  bool get isMyTurn;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
