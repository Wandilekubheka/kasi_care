import 'package:uuid/uuid.dart';

class DayData {
  final String id;
  final String description;
  final int timeSpent;
  final DateTime date;

  DayData({
    required this.description,
    required this.timeSpent,
    required this.date,
    String? id,
  }) : id = id ?? Uuid().v4();

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      timeSpent: json['timeSpent'] ?? 0,
      date: DateTime.parse(json['date']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'timeSpent': timeSpent,
      'date': date.toIso8601String(),
    };
  }

  DayData copyWith({
    String? id,
    String? description,
    int? timeSpent,
    DateTime? date,
  }) {
    return DayData(
      id: id ?? this.id,
      description: description ?? this.description,
      timeSpent: timeSpent ?? this.timeSpent,
      date: date ?? this.date,
    );
  }
}
