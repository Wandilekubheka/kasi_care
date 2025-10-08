import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasi_care/features/home/data/models/day.dart';

class FirestoreService {
  final String userId;
  final FirebaseFirestore firebaseFirestore;
  FirestoreService({required this.userId, required this.firebaseFirestore});
  Future<List<DayData>> fetchMonthData(DateTime date) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('${date.year - date.month}')
          .get();

      return querySnapshot.docs
          .map((doc) => DayData.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addData(DayData dayData) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('${dayData.id.year - dayData.id.month}')
          .doc(dayData.id.toIso8601String())
          .set(dayData.toJson());
    } catch (e) {
      rethrow;
    }
    // Implementation for adding data to Firestore
  }

  Future<void> updateData(DayData dayData) async {
    // Implementation for updating data in Firestore
  }

  Future<void> deleteData(DateTime id) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('${id.year - id.month}')
          .doc(id.toIso8601String())
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<DayData>>> fetchOverallData() async {
    // Implementation for fetching user data from Firestore
    return {};
  }
}
