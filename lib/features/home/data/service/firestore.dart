import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clock_mate/features/home/data/models/day.dart';

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
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => DayData.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addData(DayData dayData) async {
    print('id is ${dayData.id}');

    try {
      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('${dayData.date.year - dayData.date.month}')
          .doc(dayData.id)
          .set(dayData.toJson());
    } catch (e) {
      rethrow;
    }
    // Implementation for adding data to Firestore
  }

  Future<void> updateData(DayData dayData) async {
    // Implementation for updating data in Firestore
  }

  Future<void> deleteData(DayData id) async {
    print('id is ${id.id}');
    try {
      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('${id.date.year - id.date.month}')
          .doc(id.id)
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
