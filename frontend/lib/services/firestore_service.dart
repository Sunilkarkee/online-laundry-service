import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/data/models/custom_order.dart';
import 'package:frontend/data/models/user.dart';
import '../data/models/service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Services
  Stream<List<Service>> getServicesStream() {
    return _firestore.collection('services').snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return <Service>[]; // Return empty list if no documents found
      }
      return snapshot.docs
          .map((doc) => Service.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Orders
  Future<String> createOrder(CustomOrder order) async {
    final docRef = await _firestore.collection('orders').add(order.toMap());
    return docRef.id;
  }

  Stream<List<CustomOrder>> getUserOrdersStream(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) {
            return <CustomOrder>[]; // Return empty list if no documents found
          }
          return snapshot.docs
              .map((doc) => CustomOrder.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status,
    });
  }

  // Update User in Firestore
  Future<void> updateUser(User updatedUser) async {
    try {
      await _firestore.collection('users').doc(updatedUser.id).update({
        'email': updatedUser.email,
        'name': updatedUser.name,
        'phone': updatedUser.phone,
        'addresses': updatedUser.addresses,
        'createdAt': Timestamp.fromDate(updatedUser.createdAt),
      });
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  // Fetch User from Firestore by User ID
  Future<User?> getUser(String userId) async {
    try {
      final docSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return User.fromJson(docSnapshot.data()!, docSnapshot.id);
      }
      return null; // User not found
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  // Fetch User Orders (non-stream version, single fetch)
  Future<List<CustomOrder>> getUserOrders(String userId) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('orders')
              .where('userId', isEqualTo: userId)
              .orderBy('createdAt', descending: true)
              .get();

      return querySnapshot.docs.map((doc) {
        return CustomOrder.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching user orders: $e');
    }
  }

  // Cancel an order by ID
  Future<void> cancelOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': 'cancelled',
      });
    } catch (e) {
      throw Exception('Error cancelling order: $e');
    }
  }

  // Remove an address from the user profile
  Future<void> removeUserAddress(
    String userId,
    Map<String, dynamic> address,
  ) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final user = User.fromJson(userDoc.data()!, userDoc.id);
        List<Map<String, dynamic>> updatedAddresses = List.from(user.addresses);
        updatedAddresses.remove(address);

        await _firestore.collection('users').doc(userId).update({
          'addresses': updatedAddresses,
        });
      }
    } catch (e) {
      throw Exception('Error removing address: $e');
    }
  }

  // Add a new address to the user profile
  Future<void> addUserAddress(
    String userId,
    Map<String, dynamic> address,
  ) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final user = User.fromJson(userDoc.data()!, userDoc.id);
        List<Map<String, dynamic>> updatedAddresses = List.from(user.addresses);
        updatedAddresses.add(address);

        await _firestore.collection('users').doc(userId).update({
          'addresses': updatedAddresses,
        });
      }
    } catch (e) {
      throw Exception('Error adding address: $e');
    }
  }
}
