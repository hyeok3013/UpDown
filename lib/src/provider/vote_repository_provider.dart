import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/repository/vote_repository.dart';

part 'vote_repository_provider.g.dart';

@riverpod
VoteRepository voteRepository(VoteRepositoryRef ref) {
  return VoteRepository();
}
