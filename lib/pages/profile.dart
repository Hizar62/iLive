import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live/resources/add_data.dart';
import 'package:live/services/auth_service.dart';
import 'package:live/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Uint8List? _image;
  bool _isSaving = false;

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
        const SnackBar(content: Text('Please select an image before saving.')),
      );
      return;
    }

    setState(() {
      _isSaving = true; // Start saving
    });

    try {
      print("Initiating profile save...");
      String result = await StoreData().saveData(file: _image!);
      print("Profile save result: $result");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(result == 'success'
                ? 'Profile saved successfully!'
                : 'Failed to save profile: $result')),
      );
    } catch (e) {
      print("Error in saveProfile function: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('An error occurred while saving the profile: $e')),
      );
    } finally {
      setState(() {
        _isSaving = false; // End saving
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
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/premium-vector/blue-silhouette-person-s-face-against-white-background_754208-70.jpg'),
                    ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo)),
              )
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 218, 20, 20),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: _isSaving ? null : saveProfile,
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Save')),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 218, 20, 20),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () async {
                await AuthService().signout(context: context);
              },
              child: const Text('Logout')),
        ],
      ),
    ));
  }
}
