import 'package:kasi_care/features/home/data/models/day.dart';

abstract class CalendarRepository {
  Future<List<DayData>> fetchMonthlyData(DateTime date);
  Future<void> addDataToMonth(DayData data);
  Future<void> updateData(DayData dayData);
  Future<void> deleteData(DateTime id);
}
