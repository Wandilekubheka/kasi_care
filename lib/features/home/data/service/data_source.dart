import 'package:kasi_care/features/home/data/models/day.dart';
import 'package:kasi_care/features/home/data/service/firestore.dart';
import 'package:kasi_care/features/home/data/service/local_database.dart';

class DataSource {
  final FirestoreService firestoreService;
  final LocalDatabase localDatabase;
  const DataSource({
    required this.firestoreService,
    required this.localDatabase,
  });

  Future<void> saveData(DayData dayData) async {
    try {
      await firestoreService.addData(dayData);
      await localDatabase.saveData(dayData);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DayData>> fetchMonthData(DateTime date) async {
    try {
      return await firestoreService.fetchMonthData(date);
    } catch (e) {
      rethrow;
    }
  }
}
