import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clock_mate/core/data/models/app_user.dart';
import 'package:clock_mate/features/auth/data/services/fireabse_auth.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseFirestore _firebaseInstance;

  AuthRepository(this._firebaseAuthService, this._firebaseInstance);

  Future<AppUser> signIn(String email, String password) async {
    try {
      //  sign in user
      String uid = await _firebaseAuthService.signInWithEmail(email, password);
      // fetch user data from firestore
      final doc = await _firebaseInstance.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return AppUser.fromJson(doc.data()!);
      }
      throw FormatException("unable to fetch user data");
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser> register(
    String email,
    String password,
    String fullname,
  ) async {
    try {
      //create user
      final user = await _firebaseAuthService.registerWithEmail(
        email,
        password,
        fullname,
      );
      // create app user from firebase user
      final AppUser appUser = AppUser(
        id: user.uid,
        email: email,
        fullname: fullname,
      );
      // store user data in firestore
      await _firebaseInstance
          .collection('users')
          .doc(user.uid)
          .set(appUser.toJson());

      return appUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuthService.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
