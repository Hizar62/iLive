import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderName;
  final String userId;
  final String message;
  final Timestamp timeStamp;

  Message(
      {required this.senderId,
      required this.senderName,
      required this.userId,
      required this.message,
      required this.timeStamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'userId': userId,
      'message': message,
      'timeStamp': timeStamp
    };
  }
}
