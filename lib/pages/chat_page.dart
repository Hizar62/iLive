import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live/components/chat_bubble.dart';
import 'package:live/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUsername;
  final String receiverUserId;
  final String? memeUrl; // Optional meme URL

  const ChatPage({
    super.key,
    required this.receiverUsername,
    required this.receiverUserId,
    this.memeUrl, // Accept the meme URL as an optional parameter
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // If a meme URL is provided, send it as a message automatically
    if (widget.memeUrl != null) {
      sendMessage(memeUrl: widget.memeUrl);
    }
  }

  void sendMessage({String? memeUrl}) async {
    String messageContent = memeUrl ??
        _messageController
            .text; // Use the meme URL if available, otherwise the text message

    if (messageContent.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverUserId, messageContent,
          messageType: memeUrl != null
              ? 'image'
              : 'text' // If it's a meme URL, messageType is 'image'
          );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUsername),
        backgroundColor: const Color.fromARGB(255, 218, 20, 20),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),

          // user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Snapshot Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No messages yet.');
          }

          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  // build message item
// build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    bool _isImageUrl(String url) {
      return url.endsWith('.png') ||
          url.endsWith('.jpg') ||
          url.endsWith('.jpeg') ||
          url.endsWith('.gif') ||
          url.endsWith('.bmp');
    }

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    bool isImage = _isImageUrl(data['message']);

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment == Alignment.centerRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (alignment ==
              Alignment.centerLeft) // Show avatar for other users' messages
            FutureBuilder<String?>(
              future: _getProfileImage(data['senderId']), // Fetch profile image
              builder: (context, snapshot) {
                String profileImageUrl = snapshot.data ??
                    'https://via.placeholder.com/150'; // Default image

                return CircleAvatar(
                  radius: 20, // Adjust the size
                  backgroundImage: NetworkImage(profileImageUrl),
                );
              },
            ),
          const SizedBox(
              width: 10), // Add some space between the avatar and message
          Column(
            crossAxisAlignment: alignment == Alignment.centerRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              isImage
                  ? Image.network(
                      data['message'],
                      width: 250,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.red),
                    )
                  : chatBubble(
                      message: data['message']), // Otherwise, show as text
            ],
          ),
        ],
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding:
          const EdgeInsets.all(8.0), // Outer padding for the whole input row
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color for the input field
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: _messageController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter a Message',
                    border: InputBorder.none, // Removes the default underline
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward_outlined),
              color: Colors.redAccent, // Icon color
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> _getProfileImage(String uid) async {
  try {
    DocumentSnapshot userProfile = await FirebaseFirestore.instance
        .collection('userProfile')
        .doc(uid)
        .get();

    if (userProfile.exists) {
      return userProfile['imageLink'] as String?;
    }
  } catch (e) {
    print('Error fetching profile image for user $uid: $e');
  }
  return null; // Return null if there's an error or no image is found
}
