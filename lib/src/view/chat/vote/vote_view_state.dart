import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/src/model/vote.dart';

part 'vote_view_state.freezed.dart';

@freezed
class VoteViewState with _$VoteViewState {
  const factory VoteViewState({
    required List<Message> messages, // 채팅 메시지 리스트
    required Vote vote, // 투표 상태 (투표 대상, 결과)
  }) = _VoteViewState;
}
