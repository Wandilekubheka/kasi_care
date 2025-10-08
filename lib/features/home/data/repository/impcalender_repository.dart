import 'package:kasi_care/features/home/data/models/day.dart';
import 'package:kasi_care/features/home/data/service/firestore.dart';
import 'package:kasi_care/features/home/data/service/local_database.dart';
import 'package:kasi_care/features/home/domain/repository/calendar_repository.dart';

class ImpCalendarRepository implements CalendarRepository {
  final String userId;
  final FirestoreService firestoreService;
  final LocalDatabase localDatabase;
  ImpCalendarRepository({
    required this.userId,
    required this.firestoreService,
    required this.localDatabase,
  });
  @override
  Future<List<DayData>> fetchMonthlyData(DateTime date) async {
    return await firestoreService.fetchMonthData(date);
  }

  @override
  Future<void> addDataToMonth(DayData dayData) async {
    return await firestoreService.addData(dayData);
  }

  @override
  Future<void> updateData(DayData date) async {
    return await firestoreService.updateData(date);
  }

  @override
  Future<void> deleteData(DateTime date) async {
    return await firestoreService.deleteData(date);
  }
}
