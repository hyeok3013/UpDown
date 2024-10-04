// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResultViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<VoteResultItem> results) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<VoteResultItem> results)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<VoteResultItem> results)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultViewStateCopyWith<$Res> {
  factory $ResultViewStateCopyWith(
          ResultViewState value, $Res Function(ResultViewState) then) =
      _$ResultViewStateCopyWithImpl<$Res, ResultViewState>;
}

/// @nodoc
class _$ResultViewStateCopyWithImpl<$Res, $Val extends ResultViewState>
    implements $ResultViewStateCopyWith<$Res> {
  _$ResultViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ResultViewStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ResultViewState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<VoteResultItem> results) success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<VoteResultItem> results)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<VoteResultItem> results)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ResultViewState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ResultViewStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ResultViewState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<VoteResultItem> results) success,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<VoteResultItem> results)? success,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<VoteResultItem> results)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ResultViewState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<VoteResultItem> results});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ResultViewStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_$SuccessImpl(
      null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<VoteResultItem>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(final List<VoteResultItem> results) : _results = results;

  final List<VoteResultItem> _results;
  @override
  List<VoteResultItem> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'ResultViewState.success(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<VoteResultItem> results) success,
  }) {
    return success(results);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<VoteResultItem> results)? success,
  }) {
    return success?.call(results);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<VoteResultItem> results)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ResultViewState {
  const factory _Success(final List<VoteResultItem> results) = _$SuccessImpl;

  List<VoteResultItem> get results;

  /// Create a copy of ResultViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VoteResultItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get personName => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  double get forPercentage => throw _privateConstructorUsedError;
  double get againstPercentage => throw _privateConstructorUsedError;
  bool get isWinner => throw _privateConstructorUsedError;
  int get participantCount => throw _privateConstructorUsedError;
  DateTime get roomStartDate => throw _privateConstructorUsedError;
  DateTime get roomEndDate => throw _privateConstructorUsedError;
  int get guiltyCount => throw _privateConstructorUsedError;
  int get notGuiltyCount => throw _privateConstructorUsedError;

  /// Create a copy of VoteResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteResultItemCopyWith<VoteResultItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteResultItemCopyWith<$Res> {
  factory $VoteResultItemCopyWith(
          VoteResultItem value, $Res Function(VoteResultItem) then) =
      _$VoteResultItemCopyWithImpl<$Res, VoteResultItem>;
  @useResult
  $Res call(
      {String id,
      String title,
      String personName,
      List<String> participants,
      String imageUrl,
      double forPercentage,
      double againstPercentage,
      bool isWinner,
      int participantCount,
      DateTime roomStartDate,
      DateTime roomEndDate,
      int guiltyCount,
      int notGuiltyCount});
}

/// @nodoc
class _$VoteResultItemCopyWithImpl<$Res, $Val extends VoteResultItem>
    implements $VoteResultItemCopyWith<$Res> {
  _$VoteResultItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteResultItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? personName = null,
    Object? participants = null,
    Object? imageUrl = null,
    Object? forPercentage = null,
    Object? againstPercentage = null,
    Object? isWinner = null,
    Object? participantCount = null,
    Object? roomStartDate = null,
    Object? roomEndDate = null,
    Object? guiltyCount = null,
    Object? notGuiltyCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      personName: null == personName
          ? _value.personName
          : personName // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      forPercentage: null == forPercentage
          ? _value.forPercentage
          : forPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      againstPercentage: null == againstPercentage
          ? _value.againstPercentage
          : againstPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isWinner: null == isWinner
          ? _value.isWinner
          : isWinner // ignore: cast_nullable_to_non_nullable
              as bool,
      participantCount: null == participantCount
          ? _value.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      roomStartDate: null == roomStartDate
          ? _value.roomStartDate
          : roomStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      roomEndDate: null == roomEndDate
          ? _value.roomEndDate
          : roomEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      guiltyCount: null == guiltyCount
          ? _value.guiltyCount
          : guiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
      notGuiltyCount: null == notGuiltyCount
          ? _value.notGuiltyCount
          : notGuiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteResultItemImplCopyWith<$Res>
    implements $VoteResultItemCopyWith<$Res> {
  factory _$$VoteResultItemImplCopyWith(_$VoteResultItemImpl value,
          $Res Function(_$VoteResultItemImpl) then) =
      __$$VoteResultItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String personName,
      List<String> participants,
      String imageUrl,
      double forPercentage,
      double againstPercentage,
      bool isWinner,
      int participantCount,
      DateTime roomStartDate,
      DateTime roomEndDate,
      int guiltyCount,
      int notGuiltyCount});
}

/// @nodoc
class __$$VoteResultItemImplCopyWithImpl<$Res>
    extends _$VoteResultItemCopyWithImpl<$Res, _$VoteResultItemImpl>
    implements _$$VoteResultItemImplCopyWith<$Res> {
  __$$VoteResultItemImplCopyWithImpl(
      _$VoteResultItemImpl _value, $Res Function(_$VoteResultItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoteResultItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? personName = null,
    Object? participants = null,
    Object? imageUrl = null,
    Object? forPercentage = null,
    Object? againstPercentage = null,
    Object? isWinner = null,
    Object? participantCount = null,
    Object? roomStartDate = null,
    Object? roomEndDate = null,
    Object? guiltyCount = null,
    Object? notGuiltyCount = null,
  }) {
    return _then(_$VoteResultItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      personName: null == personName
          ? _value.personName
          : personName // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      forPercentage: null == forPercentage
          ? _value.forPercentage
          : forPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      againstPercentage: null == againstPercentage
          ? _value.againstPercentage
          : againstPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isWinner: null == isWinner
          ? _value.isWinner
          : isWinner // ignore: cast_nullable_to_non_nullable
              as bool,
      participantCount: null == participantCount
          ? _value.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      roomStartDate: null == roomStartDate
          ? _value.roomStartDate
          : roomStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      roomEndDate: null == roomEndDate
          ? _value.roomEndDate
          : roomEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      guiltyCount: null == guiltyCount
          ? _value.guiltyCount
          : guiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
      notGuiltyCount: null == notGuiltyCount
          ? _value.notGuiltyCount
          : notGuiltyCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VoteResultItemImpl implements _VoteResultItem {
  const _$VoteResultItemImpl(
      {required this.id,
      required this.title,
      required this.personName,
      required final List<String> participants,
      required this.imageUrl,
      required this.forPercentage,
      required this.againstPercentage,
      required this.isWinner,
      required this.participantCount,
      required this.roomStartDate,
      required this.roomEndDate,
      required this.guiltyCount,
      required this.notGuiltyCount})
      : _participants = participants;

  @override
  final String id;
  @override
  final String title;
  @override
  final String personName;
  final List<String> _participants;
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final String imageUrl;
  @override
  final double forPercentage;
  @override
  final double againstPercentage;
  @override
  final bool isWinner;
  @override
  final int participantCount;
  @override
  final DateTime roomStartDate;
  @override
  final DateTime roomEndDate;
  @override
  final int guiltyCount;
  @override
  final int notGuiltyCount;

  @override
  String toString() {
    return 'VoteResultItem(id: $id, title: $title, personName: $personName, participants: $participants, imageUrl: $imageUrl, forPercentage: $forPercentage, againstPercentage: $againstPercentage, isWinner: $isWinner, participantCount: $participantCount, roomStartDate: $roomStartDate, roomEndDate: $roomEndDate, guiltyCount: $guiltyCount, notGuiltyCount: $notGuiltyCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteResultItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.personName, personName) ||
                other.personName == personName) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.forPercentage, forPercentage) ||
                other.forPercentage == forPercentage) &&
            (identical(other.againstPercentage, againstPercentage) ||
                other.againstPercentage == againstPercentage) &&
            (identical(other.isWinner, isWinner) ||
                other.isWinner == isWinner) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.roomStartDate, roomStartDate) ||
                other.roomStartDate == roomStartDate) &&
            (identical(other.roomEndDate, roomEndDate) ||
                other.roomEndDate == roomEndDate) &&
            (identical(other.guiltyCount, guiltyCount) ||
                other.guiltyCount == guiltyCount) &&
            (identical(other.notGuiltyCount, notGuiltyCount) ||
                other.notGuiltyCount == notGuiltyCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      personName,
      const DeepCollectionEquality().hash(_participants),
      imageUrl,
      forPercentage,
      againstPercentage,
      isWinner,
      participantCount,
      roomStartDate,
      roomEndDate,
      guiltyCount,
      notGuiltyCount);

  /// Create a copy of VoteResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteResultItemImplCopyWith<_$VoteResultItemImpl> get copyWith =>
      __$$VoteResultItemImplCopyWithImpl<_$VoteResultItemImpl>(
          this, _$identity);
}

abstract class _VoteResultItem implements VoteResultItem {
  const factory _VoteResultItem(
      {required final String id,
      required final String title,
      required final String personName,
      required final List<String> participants,
      required final String imageUrl,
      required final double forPercentage,
      required final double againstPercentage,
      required final bool isWinner,
      required final int participantCount,
      required final DateTime roomStartDate,
      required final DateTime roomEndDate,
      required final int guiltyCount,
      required final int notGuiltyCount}) = _$VoteResultItemImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get personName;
  @override
  List<String> get participants;
  @override
  String get imageUrl;
  @override
  double get forPercentage;
  @override
  double get againstPercentage;
  @override
  bool get isWinner;
  @override
  int get participantCount;
  @override
  DateTime get roomStartDate;
  @override
  DateTime get roomEndDate;
  @override
  int get guiltyCount;
  @override
  int get notGuiltyCount;

  /// Create a copy of VoteResultItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteResultItemImplCopyWith<_$VoteResultItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
