import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        return _auth.currentUser!.uid;
      } else {
        throw FormatException("User not found");
      }
    } on FirebaseAuthException catch (e) {
      throw FormatException(e.message ?? "An error occurred");
    }
  }

  Future<User> registerWithEmail(
    String email,
    String password,
    String fullname,
  ) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user != null) {
        return user.user!;
      } else {
        throw FormatException("Unable to create user");
      }
    } on FirebaseAuthException catch (e) {
      throw FormatException(e.message ?? "An error occurred");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FormatException(e.message ?? "An error occurred");
    }
  }
}
