import 'package:kasi_care/features/home/data/models/day.dart';

class LocalDatabase {
  // Local database implementation

  Future<void> saveData(DayData dayData) async {
    // Save today only data locally
  }

  Future<List<DayData>> fetchData() async {
    // Fetch today only data from local database
    return [];
  }

  Future<void> updateData(DayData dayData) async {
    // Update today only data in local database
  }

  Future<void> deleteData(DateTime id) async {
    // Delete today only data from local database
  }

  Future<List<DayData>> fetchTodayData() async {
    // Fetch today only data from local database
    return [];
  }
}
