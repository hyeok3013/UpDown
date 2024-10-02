import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_view_state.freezed.dart';

@freezed
class ResultViewState with _$ResultViewState {
  const factory ResultViewState.loading() = _Loading;
  const factory ResultViewState.error(String message) = _Error;
  const factory ResultViewState.success(List<VoteResultItem> results) =
      _Success;
}

@freezed
class VoteResultItem with _$VoteResultItem {
  const factory VoteResultItem({
    required String id,
    required String title,
    required String personName,
    required List<String> participants,
    required String imageUrl,
    required double forPercentage,
    required double againstPercentage,
    required bool isWinner,
    required int participantCount,
    required DateTime roomStartDate,
    required DateTime roomEndDate,
    required int guiltyCount,
    required int notGuiltyCount,
  }) = _VoteResultItem;
}
