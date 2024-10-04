// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      personName: json['personName'] as String,
      imageUrl: json['imageUrl'] as String,
      roomStartDate: DateTime.parse(json['roomStartDate'] as String),
      roomEndDate: DateTime.parse(json['roomEndDate'] as String),
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      participantCount: (json['participantCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'personName': instance.personName,
      'imageUrl': instance.imageUrl,
      'roomStartDate': instance.roomStartDate.toIso8601String(),
      'roomEndDate': instance.roomEndDate.toIso8601String(),
      'participants': instance.participants,
      'participantCount': instance.participantCount,
    };
