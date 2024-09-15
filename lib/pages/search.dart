import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live/pages/chat_page.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List _allResult = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false; // To manage loading state

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getUserStream(); // Fetch users when the widget is initialized
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    searchResultList();
  }

  void searchResultList() {
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      final filteredResults = _allResult.where((userSnapshot) {
        final name = userSnapshot['username'].toString().toLowerCase();
        return name.contains(query);
      }).toList();

      setState(() {
        _resultList = filteredResults;
      });
    } else {
      setState(() {
        _resultList = [];
      });
    }
  }

  Future<void> getUserStream() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('username')
          .get();

      setState(() {
        _allResult = data.docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching users: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: _searchController,
          placeholder: 'Search users',
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchController.text.isEmpty
              ? const Center(
                  child: Text(
                    'Enter a search term to find users',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : _resultList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _resultList.length,
                      itemBuilder: (context, index) {
                        final user = _resultList[index];

                        return FutureBuilder<String?>(
                          future: _getProfileImage(user['uid']),
                          builder: (context, snapshot) {
                            String profileImageUrl = snapshot.data ??
                                'https://via.placeholder.com/150'; // Default image if none

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(profileImageUrl),
                              ),
                              title: Text(user['username']),
                              subtitle: Text(user['email']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      receiverUsername: user['username'],
                                      receiverUserId: user['uid'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No users found matching your search',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
    );
  }
}
