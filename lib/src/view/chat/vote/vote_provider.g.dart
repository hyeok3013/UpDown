// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$voteHash() => r'670b639f93c4218f5f62c3871a5d2cb86cc557fa';

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

abstract class _$Vote extends BuildlessAutoDisposeAsyncNotifier<List<Message>> {
  late final String roomId;

  FutureOr<List<Message>> build({
    required String roomId,
  });
}

/// See also [Vote].
@ProviderFor(Vote)
const voteProvider = VoteFamily();

/// See also [Vote].
class VoteFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [Vote].
  const VoteFamily();

  /// See also [Vote].
  VoteProvider call({
    required String roomId,
  }) {
    return VoteProvider(
      roomId: roomId,
    );
  }

  @override
  VoteProvider getProviderOverride(
    covariant VoteProvider provider,
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
  String? get name => r'voteProvider';
}

/// See also [Vote].
class VoteProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Vote, List<Message>> {
  /// See also [Vote].
  VoteProvider({
    required String roomId,
  }) : this._internal(
          () => Vote()..roomId = roomId,
          from: voteProvider,
          name: r'voteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$voteHash,
          dependencies: VoteFamily._dependencies,
          allTransitiveDependencies: VoteFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  VoteProvider._internal(
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
  FutureOr<List<Message>> runNotifierBuild(
    covariant Vote notifier,
  ) {
    return notifier.build(
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(Vote Function() create) {
    return ProviderOverride(
      origin: this,
      override: VoteProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<Vote, List<Message>> createElement() {
    return _VoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VoteProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VoteRef on AutoDisposeAsyncNotifierProviderRef<List<Message>> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _VoteProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Vote, List<Message>>
    with VoteRef {
  _VoteProviderElement(super.provider);

  @override
  String get roomId => (origin as VoteProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
