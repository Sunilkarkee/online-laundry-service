import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final List<Map<String, dynamic>> addresses;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.addresses = const [],
    required this.createdAt,
  });

  // From Firestore Document or JSON
  factory User.fromJson(Map<String, dynamic> json, String id) {
    return User(
      id: id,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      addresses:
          json['addresses'] != null
              ? List<Map<String, dynamic>>.from(json['addresses'])
              : [],
      createdAt:
          (json['createdAt'] as Timestamp)
              .toDate(), // Assuming createdAt is a Firestore Timestamp
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'addresses': addresses,
      'createdAt': Timestamp.fromDate(
        createdAt,
      ), // Firestore requires Timestamp for DateTime
    };
  }

  // copyWith method for updating User object
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    List<Map<String, dynamic>>? addresses,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      addresses: addresses ?? this.addresses,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Convert a User object from a Map (e.g., Firestore Document)
  static User fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      addresses:
          map['addresses'] != null
              ? List<Map<String, dynamic>>.from(map['addresses'])
              : [],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert a User object to a Map (used for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'addresses': addresses,
      'createdAt': Timestamp.fromDate(createdAt), // Firestore Timestamp
    };
  }
}
