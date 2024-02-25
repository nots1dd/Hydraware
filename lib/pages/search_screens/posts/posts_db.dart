import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  Future<void> addPost(String message, String area) {
    return db.collection("Posts").add({
      'message': message,
      'timestamp': DateTime.now(),
      'mail': user!.email,
      'area': area,
      'Likes': []
    });
  }

  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance.collection("Posts").orderBy('timestamp', descending: true).snapshots();
    return postsStream;
  }
}