import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future<User?> signUpWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) {
      // The user canceled the Google sign-in process.
      return null;
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    try {
      // Attempt to sign in the user with Firebase Authentication.
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is new (just signed up).
      if (userCredential.additionalUserInfo!.isNewUser) {
        // If the user is new, create a user document in Firestore.
        await createNewUserDocument(userCredential.user!);
      }

      return userCredential.user;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  Future<void> createNewUserDocument(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'displayName': user.displayName,
      'email': user.email,
    });
  }
}
