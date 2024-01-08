import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<String?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user?.uid ?? '';
      String imageUrl = "https://firebasestorage.googleapis.com/v0/b/tubes-iot-affe1.appspot.com/o/profile_images%2Fno-photo-available.png?alt=media&token=99c3e85d-64ff-4353-82a3-cb746f81e2c1";
      db.collection("userData").doc(uid).set({
        "username": username,
        "image": imageUrl,
        "role": "none",
      }).onError((error, stackTrace) => print("Error writing : $error"));

      return 'Registration Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Login Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}