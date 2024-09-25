import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_down/src/model/room.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/helper/handle_exception.dart';

class RoomRepository {
  ///방 조회
  Future<List<Room>> getRooms() async {
    try {
      final QuerySnapshot roomsCol = await roomsCollection.get();

      if (roomsCol.docs.isNotEmpty) {
        final List<Room> rooms = roomsCol.docs.map((doc) {
          return Room.fromDoc(doc);
        }).toList();

        // 방 리스트 반환
        return rooms;
      }

      throw 'User not found';
    } catch (e) {
      throw handleException(e);
    }
  }

  ///방 생성
  Future<void> createRoom(Room room) async {
    try {
      await roomsCollection.doc(room.roomId).set({
        'roomId': room.roomId,
        'roomName': room.roomName,
        'personName': room.personName,
        'imageUrl': room.imageUrl,
        'roomStartDate': room.roomStartDate,
        'roomEndDate': room.roomEndDate,
      });
    } catch (e) {
      throw handleException(e);
    }
  }
}

///방 예시
// final room = Room(
//   roomId: 'uniqueRoomId123',  // 고유한 방 ID
//   roomName: 'Flutter Study Group',
//   personName: 'Kim',
//   imageUrl: 'https://example.com/image.png',
//   roomStartDate: Timestamp.now(),
//   roomEndDate: Timestamp.now().add(Duration(hours: 1)),
// );
