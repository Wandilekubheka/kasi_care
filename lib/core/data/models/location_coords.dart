class LocationCoords {
  final double latitude;
  final double longitude;

  LocationCoords({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  factory LocationCoords.fromJson(Map<String, dynamic> json) {
    return LocationCoords(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }
}
