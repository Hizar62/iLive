import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live/model/message.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Send Message
  Future<void> sendMessage(String recevierId, String message) async {
    // get current info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserName = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderName: currentUserName,
        userId: recevierId,
        message: message,
        timeStamp: timestamp);

    // construct chat room id

    // add new message to database
  }

  // Get Message
}
