import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      return null; // Return null if the sign-in process is canceled
    }
    
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userCredential.user!.email)
        .set({
      'username': userCredential.user!.email!.split('@')[0],
      'email': userCredential.user!.email,
      'uid': userCredential.user!.uid,
    });

    return userCredential;
  }
}

