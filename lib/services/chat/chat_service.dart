import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:live/model/message.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send Message
  Future<void> sendMessage(String receiverId, String message,
      {String messageType = 'text'}) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserName = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message with type
    Message newMessage = Message(
        senderId: currentUserId,
        senderName: currentUserName,
        userId: receiverId,
        message: message,
        messageType: messageType, // Store message type (text or image)
        timeStamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    print('Sending message to chat room: $chatRoomId');
    print('Message: ${newMessage.toMap()}');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap())
        .then((value) => print("Message sent successfully"))
        .catchError((error) => print("Failed to send message: $error"));
  }

  // Get Message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    print('Fetching messages for chat room: $chatRoomId');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages') // Ensure collection name is correct
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
