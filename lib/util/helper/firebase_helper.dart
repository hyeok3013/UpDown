import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final usersCollection = FirebaseFirestore.instance.collection('users_test');
final roomsCollection = FirebaseFirestore.instance.collection('rooms_test');
final messagesCollection =
    FirebaseFirestore.instance.collection('messages_test');
final participantsCollection =
    FirebaseFirestore.instance.collection('participants_test');
final fbAuth = FirebaseAuth.instance;
