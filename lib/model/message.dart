import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderName;
  final String userId;
  final String message;
  final String messageType; // New field for message type
  final Timestamp timeStamp;

  Message({
    required this.senderId,
    required this.senderName,
    required this.userId,
    required this.message,
    this.messageType = 'text', // Default to 'text'
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'userId': userId,
      'message': message,
      'messageType': messageType, // Include messageType in map
      'timeStamp': timeStamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      senderName: map['senderName'],
      userId: map['userId'],
      message: map['message'],
      messageType: map['messageType'] ?? 'text', // Safely handle missing field
      timeStamp: map['timeStamp'],
    );
  }
}
