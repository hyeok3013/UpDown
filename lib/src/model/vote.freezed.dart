// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Vote {
  String get voteId => throw _privateConstructorUsedError; // 투표의 고유 ID
  String get roomId =>
      throw _privateConstructorUsedError; // 채팅방 ID (투표 대상의 사람과 연결)
  String get personName =>
      throw _privateConstructorUsedError; // 투표 대상 (채팅방 제목 = 사람 이름)
  int get guiltyCount => throw _privateConstructorUsedError; // 잘못했다는 투표 수
  int get notGuiltyCount =>
      throw _privateConstructorUsedError; // 잘못하지 않았다는 투표 수
  List<String> get participants => throw _privateConstructorUsedError;

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteCopyWith<Vote> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteCopyWith<$Res> {
  factory $VoteCopyWith(Vote value, $Res Function(Vote) then) =
      _$VoteCopyWithImpl<$Res, Vote>;
  @useResult
  $Res call(
      {String voteId,
      String roomId,
      String personName,
      int guiltyCount,
      int notGuiltyCount,
      List<String> participants});
}

/// @nodoc
class _$VoteCopyWithImpl<$Res, $Val extends Vote>
    implements $VoteCopyWith<$Res> {
  _$VoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voteId = null,
    Object? roomId = null,
    Object? personName = null,
    Object? guiltyCount = null,
    Object? notGuiltyCount = null,
    Object? participants = null,
  }) {
    return _then(_value.copyWith(
      voteId: null == voteId
          ? _value.voteId
          : voteId // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      personName: null == personName
          ? _value.personName
          : personName // ignore: cast_nullable_to_non_nullable
              as String,
      guiltyCount: null == guiltyCount
          ? _value.guiltyCount
          : guiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
      notGuiltyCount: null == notGuiltyCount
          ? _value.notGuiltyCount
          : notGuiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteImplCopyWith<$Res> implements $VoteCopyWith<$Res> {
  factory _$$VoteImplCopyWith(
          _$VoteImpl value, $Res Function(_$VoteImpl) then) =
      __$$VoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String voteId,
      String roomId,
      String personName,
      int guiltyCount,
      int notGuiltyCount,
      List<String> participants});
}

/// @nodoc
class __$$VoteImplCopyWithImpl<$Res>
    extends _$VoteCopyWithImpl<$Res, _$VoteImpl>
    implements _$$VoteImplCopyWith<$Res> {
  __$$VoteImplCopyWithImpl(_$VoteImpl _value, $Res Function(_$VoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voteId = null,
    Object? roomId = null,
    Object? personName = null,
    Object? guiltyCount = null,
    Object? notGuiltyCount = null,
    Object? participants = null,
  }) {
    return _then(_$VoteImpl(
      voteId: null == voteId
          ? _value.voteId
          : voteId // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      personName: null == personName
          ? _value.personName
          : personName // ignore: cast_nullable_to_non_nullable
              as String,
      guiltyCount: null == guiltyCount
          ? _value.guiltyCount
          : guiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
      notGuiltyCount: null == notGuiltyCount
          ? _value.notGuiltyCount
          : notGuiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$VoteImpl implements _Vote {
  const _$VoteImpl(
      {required this.voteId,
      required this.roomId,
      required this.personName,
      required this.guiltyCount,
      required this.notGuiltyCount,
      required final List<String> participants})
      : _participants = participants;

  @override
  final String voteId;
// 투표의 고유 ID
  @override
  final String roomId;
// 채팅방 ID (투표 대상의 사람과 연결)
  @override
  final String personName;
// 투표 대상 (채팅방 제목 = 사람 이름)
  @override
  final int guiltyCount;
// 잘못했다는 투표 수
  @override
  final int notGuiltyCount;
// 잘못하지 않았다는 투표 수
  final List<String> _participants;
// 잘못하지 않았다는 투표 수
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  String toString() {
    return 'Vote(voteId: $voteId, roomId: $roomId, personName: $personName, guiltyCount: $guiltyCount, notGuiltyCount: $notGuiltyCount, participants: $participants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteImpl &&
            (identical(other.voteId, voteId) || other.voteId == voteId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.personName, personName) ||
                other.personName == personName) &&
            (identical(other.guiltyCount, guiltyCount) ||
                other.guiltyCount == guiltyCount) &&
            (identical(other.notGuiltyCount, notGuiltyCount) ||
                other.notGuiltyCount == notGuiltyCount) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      voteId,
      roomId,
      personName,
      guiltyCount,
      notGuiltyCount,
      const DeepCollectionEquality().hash(_participants));

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteImplCopyWith<_$VoteImpl> get copyWith =>
      __$$VoteImplCopyWithImpl<_$VoteImpl>(this, _$identity);
}

abstract class _Vote implements Vote {
  const factory _Vote(
      {required final String voteId,
      required final String roomId,
      required final String personName,
      required final int guiltyCount,
      required final int notGuiltyCount,
      required final List<String> participants}) = _$VoteImpl;

  @override
  String get voteId; // 투표의 고유 ID
  @override
  String get roomId; // 채팅방 ID (투표 대상의 사람과 연결)
  @override
  String get personName; // 투표 대상 (채팅방 제목 = 사람 이름)
  @override
  int get guiltyCount; // 잘못했다는 투표 수
  @override
  int get notGuiltyCount; // 잘못하지 않았다는 투표 수
  @override
  List<String> get participants;

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteImplCopyWith<_$VoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
