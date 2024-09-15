import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live/resources/add_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live/services/auth_service.dart';
import 'package:live/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Uint8List? _image;
  String? _profileImageUrl;
  bool _isSaving = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  void _loadProfileImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? currentUser =
          FirebaseAuth.instance.currentUser; // Get current user's UID
      if (currentUser != null) {
        String uid = currentUser.uid;

        // Retrieve the image URL from Firestore using UID
        DocumentSnapshot userProfile = await FirebaseFirestore.instance
            .collection('userProfile')
            .doc(uid)
            .get();

        if (userProfile.exists) {
          setState(() {
            _profileImageUrl =
                userProfile.get('imageLink'); // Retrieve the image URL
          });
        }
      }
    } catch (e) {
      print('Error loading profile image: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void selectImage() async {
    try {
      Uint8List img = await pickImage(ImageSource.gallery);
      setState(() {
        _image = img;
      });
    } catch (e) {
      print("Error selecting image: $e");
    }
  }

  void saveProfile() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image before saving.'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      String result =
          await StoreData().saveData(file: _image!); // Save with UID
      if (result == 'success') {
        _loadProfileImage(); // Reload profile image after saving
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile saved successfully!'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save profile: $result'),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          ),
        );
      }
    } catch (e) {
      print("Error in saveProfile function: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while saving the profile: $e'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                _isLoading
                    ? const CircularProgressIndicator() // Show loader while image is being fetched
                    : (_image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : (_profileImageUrl != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage:
                                    NetworkImage(_profileImageUrl!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://img.freepik.com/premium-vector/blue-silhouette-person-s-face-against-white-background_754208-70.jpg'),
                              ))),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 20, 20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: _isSaving ? null : saveProfile,
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Save'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 20, 20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                await AuthService().signout(context: context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
