import 'package:kasi_care/core/data/models/location_coords.dart';

class AppUser {
  final String id;
  final String email;
  final String fullname;
  final String? profilePictureUrl;
  final String? phoneNumber;
  final String? address;
  final LocationCoords? location;

  AppUser({
    required this.id,
    required this.email,
    required this.fullname,
    this.profilePictureUrl,
    this.phoneNumber,
    this.address,
    this.location,
  });
  AppUser copyWith({
    String? id,
    String? email,
    String? fullname,
    String? profilePictureUrl,
    String? phoneNumber,
    String? address,
    LocationCoords? location,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      location: location ?? this.location,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      fullname: map['fullname'] ?? '',
      profilePictureUrl: map['profilePictureUrl'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      location: map['location'] != null
          ? LocationCoords(
              latitude: map['location']['latitude'],
              longitude: map['location']['longitude'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullname': fullname,
      'profilePictureUrl': profilePictureUrl,
      'phoneNumber': phoneNumber,
      'address': address,
      'location': location != null
          ? {'latitude': location!.latitude, 'longitude': location!.longitude}
          : null,
    };
  }
}
