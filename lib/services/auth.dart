import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  Future googleLogin() async {
    try {
      final googleUser =
          await GoogleSignIn(scopes: ['profile', 'email']).signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  Future logOut() async {
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
