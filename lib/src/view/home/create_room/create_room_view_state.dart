// lib/src/view/home/create_room_view_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_room_view_state.freezed.dart';

@freezed
class CreateRoomViewState with _$CreateRoomViewState {
  factory CreateRoomViewState({
    DateTime? roomStartDate,
    DateTime? roomEndDate,
    String? imageUrl, // imageUrl 필드 추가
  }) = _CreateRoomViewState;
}
