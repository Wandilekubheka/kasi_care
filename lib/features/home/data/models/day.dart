class DayData {
  final DateTime id;
  final String description;
  final int timeSpent;
  final DateTime date;

  DayData({
    required this.id,
    required this.description,
    required this.timeSpent,
    required this.date,
  });

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      id: DateTime.parse(json['id']),
      description: json['description'] ?? '',
      timeSpent: json['timeSpent'] ?? 0,
      date: DateTime.parse(json['date']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id.toIso8601String(),
      'description': description,
      'timeSpent': timeSpent,
      'date': date.toIso8601String(),
    };
  }

  DayData copyWith({
    DateTime? id,
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
