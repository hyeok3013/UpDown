// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$judgmentHash() => r'94e9e612905d1d6eeb5d64dc827ed0ce1fed234a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Judgment
    extends BuildlessAutoDisposeAsyncNotifier<VoteViewState> {
  late final String roomId;

  FutureOr<VoteViewState> build({
    required String roomId,
  });
}

/// See also [Judgment].
@ProviderFor(Judgment)
const judgmentProvider = JudgmentFamily();

/// See also [Judgment].
class JudgmentFamily extends Family<AsyncValue<VoteViewState>> {
  /// See also [Judgment].
  const JudgmentFamily();

  /// See also [Judgment].
  JudgmentProvider call({
    required String roomId,
  }) {
    return JudgmentProvider(
      roomId: roomId,
    );
  }

  @override
  JudgmentProvider getProviderOverride(
    covariant JudgmentProvider provider,
  ) {
    return call(
      roomId: provider.roomId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'judgmentProvider';
}

/// See also [Judgment].
class JudgmentProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Judgment, VoteViewState> {
  /// See also [Judgment].
  JudgmentProvider({
    required String roomId,
  }) : this._internal(
          () => Judgment()..roomId = roomId,
          from: judgmentProvider,
          name: r'judgmentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$judgmentHash,
          dependencies: JudgmentFamily._dependencies,
          allTransitiveDependencies: JudgmentFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  JudgmentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  FutureOr<VoteViewState> runNotifierBuild(
    covariant Judgment notifier,
  ) {
    return notifier.build(
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(Judgment Function() create) {
    return ProviderOverride(
      origin: this,
      override: JudgmentProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Judgment, VoteViewState>
      createElement() {
    return _JudgmentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JudgmentProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin JudgmentRef on AutoDisposeAsyncNotifierProviderRef<VoteViewState> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _JudgmentProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Judgment, VoteViewState>
    with JudgmentRef {
  _JudgmentProviderElement(super.provider);

  @override
  String get roomId => (origin as JudgmentProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
