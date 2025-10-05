import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseInstance {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
}
