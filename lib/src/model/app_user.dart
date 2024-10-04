import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    @Default('') String id,
    @Default('') String name,
    @Default('') String email,
    @Default('') String fcmToken,
  }) = _AppUser;

  factory AppUser.fromDoc(DocumentSnapshot appUserDoc) {
    final appUserData = appUserDoc.data() as Map<String, dynamic>;

    return AppUser(
      id: appUserDoc.id,
      name: appUserData['name'] ?? '',
      email: appUserData['email'] ?? '',
      fcmToken: appUserData['fcmToken'] ?? '',
    );
  }
}
