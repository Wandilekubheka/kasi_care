import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_care/features/home/blocs/home/home_state.dart';
import 'package:kasi_care/features/home/data/models/day.dart';
import 'package:kasi_care/features/home/data/repository/impcalender_repository.dart';

class HomeCupit extends Cubit<HomeState> {
  final ImpCalendarRepository dataSource;
  HomeCupit(this.dataSource) : super(HomeInitial()) {
    fetchData(DateTime.now());
  }

  Future<void> fetchData(DateTime date) async {
    emit(HomeLoading());
    try {
      final monthData = await dataSource.fetchMonthlyData(date);
      emit(HomeMonthData(monthData));
    } catch (e) {
      if (e is FormatException) {
        emit(HomeError(e.message));
      } else {
        print(e);
        emit(HomeError('An unexpected error occurred'));
      }
    }
  }

  Future<void> addData(DayData dayData) async {
    emit(HomeLoading());
    try {
      await dataSource.addDataToMonth(dayData);
      final monthData = await dataSource.fetchMonthlyData(dayData.date);
      emit(HomeMonthData(monthData));
    } catch (e) {
      if (e is FormatException) {
        emit(HomeError(e.message));
      } else {
        emit(HomeError('An unexpected error occurred'));
      }
    }
  }
}
