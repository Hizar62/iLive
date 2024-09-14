import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    String downloadUrl = '';
    try {
      print("Starting image upload...");
      Reference ref = _storage.ref().child(childName);
      UploadTask uploadTask = ref.putData(file);

      // Await upload task completion and check for errors
      TaskSnapshot snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
      print("Image uploaded successfully, URL: $downloadUrl");
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      throw ('Image upload failed: $e');
    }
    return downloadUrl;
  }

  Future<String> saveData({required Uint8List file}) async {
    String response = "Some Error Occurred";
    try {
      print("Saving image to Firebase Storage...");
      String imageUrl = await uploadImageToStorage('profileImage', file);

      print("Saving image URL to Firestore...");
      await _firestore.collection('userProfile').add({'imageLink': imageUrl});

      print("Data saved successfully to Firestore.");
      response = 'success';
    } catch (err) {
      print('Error saving data to Firestore: $err');
      response = 'Failed: $err';
    }
    return response;
  }
}
