// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VoteViewState {
  List<Message> get messages =>
      throw _privateConstructorUsedError; // 채팅 메시지 리스트
  Vote get vote => throw _privateConstructorUsedError;

  /// Create a copy of VoteViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteViewStateCopyWith<VoteViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteViewStateCopyWith<$Res> {
  factory $VoteViewStateCopyWith(
          VoteViewState value, $Res Function(VoteViewState) then) =
      _$VoteViewStateCopyWithImpl<$Res, VoteViewState>;
  @useResult
  $Res call({List<Message> messages, Vote vote});

  $VoteCopyWith<$Res> get vote;
}

/// @nodoc
class _$VoteViewStateCopyWithImpl<$Res, $Val extends VoteViewState>
    implements $VoteViewStateCopyWith<$Res> {
  _$VoteViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? vote = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      vote: null == vote
          ? _value.vote
          : vote // ignore: cast_nullable_to_non_nullable
              as Vote,
    ) as $Val);
  }

  /// Create a copy of VoteViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VoteCopyWith<$Res> get vote {
    return $VoteCopyWith<$Res>(_value.vote, (value) {
      return _then(_value.copyWith(vote: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VoteViewStateImplCopyWith<$Res>
    implements $VoteViewStateCopyWith<$Res> {
  factory _$$VoteViewStateImplCopyWith(
          _$VoteViewStateImpl value, $Res Function(_$VoteViewStateImpl) then) =
      __$$VoteViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Message> messages, Vote vote});

  @override
  $VoteCopyWith<$Res> get vote;
}

/// @nodoc
class __$$VoteViewStateImplCopyWithImpl<$Res>
    extends _$VoteViewStateCopyWithImpl<$Res, _$VoteViewStateImpl>
    implements _$$VoteViewStateImplCopyWith<$Res> {
  __$$VoteViewStateImplCopyWithImpl(
      _$VoteViewStateImpl _value, $Res Function(_$VoteViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoteViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? vote = null,
  }) {
    return _then(_$VoteViewStateImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      vote: null == vote
          ? _value.vote
          : vote // ignore: cast_nullable_to_non_nullable
              as Vote,
    ));
  }
}

/// @nodoc

class _$VoteViewStateImpl
    with DiagnosticableTreeMixin
    implements _VoteViewState {
  const _$VoteViewStateImpl(
      {required final List<Message> messages, required this.vote})
      : _messages = messages;

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

// 채팅 메시지 리스트
  @override
  final Vote vote;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoteViewState(messages: $messages, vote: $vote)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VoteViewState'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('vote', vote));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteViewStateImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.vote, vote) || other.vote == vote));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_messages), vote);

  /// Create a copy of VoteViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteViewStateImplCopyWith<_$VoteViewStateImpl> get copyWith =>
      __$$VoteViewStateImplCopyWithImpl<_$VoteViewStateImpl>(this, _$identity);
}

abstract class _VoteViewState implements VoteViewState {
  const factory _VoteViewState(
      {required final List<Message> messages,
      required final Vote vote}) = _$VoteViewStateImpl;

  @override
  List<Message> get messages; // 채팅 메시지 리스트
  @override
  Vote get vote;

  /// Create a copy of VoteViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteViewStateImplCopyWith<_$VoteViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
