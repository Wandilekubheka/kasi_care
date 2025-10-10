import 'package:clock_mate/features/home/data/models/day.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeMonthData extends HomeState {
  final List<DayData> data;
  HomeMonthData(this.data);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
