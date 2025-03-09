import 'package:cloud_firestore/cloud_firestore.dart';
import 'service.dart';

class CustomOrder {
  final String id;
  final String userId;
  final List<Service> services;
  final DateTime pickupDate;
  final DateTime deliveryDate;
  final String status;
  final double total;
  final DateTime createdAt;

  CustomOrder({
    this.id = '',
    required this.userId,
    required this.services,
    required this.pickupDate,
    required this.deliveryDate,
    this.status = 'pending',
    required this.total,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CustomOrder.fromMap(Map<String, dynamic> data, String id) {
    return CustomOrder(
      id: id,
      userId: data['userId'] ?? '',
      services:
          (data['services'] as List)
              .map(
                (s) => Service.fromMap(
                  s as Map<String, dynamic>,
                  s['id'] as String,
                ),
              )
              .toList(),
      pickupDate: (data['pickupDate'] as Timestamp).toDate(),
      deliveryDate: (data['deliveryDate'] as Timestamp).toDate(),
      status: data['status'] ?? 'pending',
      total: (data['total'] as num).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'services': services.map((s) => s.toMap()).toList(),
      'pickupDate': Timestamp.fromDate(pickupDate),
      'deliveryDate': Timestamp.fromDate(deliveryDate),
      'status': status,
      'total': total,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // The copyWith method allows you to create a new instance with modified fields
  CustomOrder copyWith({
    String? id,
    String? userId,
    List<Service>? services,
    DateTime? pickupDate,
    DateTime? deliveryDate,
    String? status,
    double? total,
    DateTime? createdAt,
  }) {
    return CustomOrder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      services: services ?? this.services,
      pickupDate: pickupDate ?? this.pickupDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      status: status ?? this.status,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
