import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live/pages/chat_page.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required String});

  @override
  State<MessageScreen> createState() => _MessageState();
}

class _MessageState extends State<MessageScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adding the Recent Chats heading
          const Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Text(
              'Recent Chats',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Expanded widget to allow the user list to take up remaining space
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return Column(
        children: [
          ListTile(
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                data['username'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold, // Custom text style
                  color: Colors.black87,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverUsername: data['username'],
                    receiverUserId: data['uid'],
                  ),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.grey, // Customize the color
            thickness: 2, // Customize the thickness
            indent: 20, // Optional: Indent the divider from the left
            endIndent: 20, // Optional: Indent the divider from the right
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
