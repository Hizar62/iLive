import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth =
    FirebaseAuth.instance; // Initialize FirebaseAuth to get UID

class StoreData {
  Future<String> uploadImageToStorage(String uid, Uint8List file) async {
    String downloadUrl = '';
    try {
      print("Starting image upload...");
      Reference ref = _storage
          .ref()
          .child('profileImages')
          .child(uid); // Use UID in storage path
      UploadTask uploadTask = ref.putData(file);

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
      // Get the current user's UID
      User? currentUser = _auth.currentUser;
      if (currentUser == null) throw 'User is not logged in';

      String uid = currentUser.uid;

      print("Saving image to Firebase Storage...");
      String imageUrl = await uploadImageToStorage(
          uid, file); // Pass UID to uploadImageToStorage

      print("Saving image URL to Firestore...");
      await _firestore.collection('userProfile').doc(uid).set({
        'imageLink': imageUrl,
      }); // Save URL under user's UID

      print("Data saved successfully to Firestore.");
      response = 'success';
    } catch (err) {
      print('Error saving data to Firestore: $err');
      response = 'Failed: $err';
    }
    return response;
  }
}
