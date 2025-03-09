// lib/data/providers/order_provider.dart
import 'package:flutter/foundation.dart';
import '../../services/firestore_service.dart';
import '../models/custom_order.dart'; // Corrected import statement

class OrderProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<CustomOrder> _orders =
      []; // Changed from 'Order' to 'CustomOrder' for consistency
  bool _isLoading = false;
  String _error = '';

  List<CustomOrder> get orders => _orders;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Load orders for a specific user
  Future<void> loadUserOrders(String userId) async {
    _isLoading = true;
    _error = ''; // Clear any previous errors
    notifyListeners();

    try {
      // Fetch orders from Firestore service
      _orders = await _firestoreService.getUserOrders(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load orders: ${e.toString()}';
      notifyListeners();
    }
  }

  // Refresh orders for the current user
  Future<void> refreshOrders(String userId) async {
    await loadUserOrders(userId);
  }

  // Create a new order
  Future<String?> createOrder(CustomOrder order) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Create order using Firestore service and get the order ID
      final orderId = await _firestoreService.createOrder(order);
      _orders.insert(
        0,
        order.copyWith(id: orderId, status: ''),
      ); // Insert the new order at the beginning
      _isLoading = false;
      notifyListeners();
      return orderId;
    } catch (e) {
      _isLoading = false;
      _error = 'Order creation failed: ${e.toString()}';
      notifyListeners();
      return null;
    }
  }

  // Cancel an order by its ID
  Future<bool> cancelOrder(String orderId) async {
    try {
      // Call Firestore service to cancel the order
      await _firestoreService.cancelOrder(orderId);
      final index = _orders.indexWhere((o) => o.id == orderId);

      // If order found, update its status to 'cancelled'
      if (index >= 0) {
        _orders[index] = _orders[index].copyWith(status: 'cancelled', id: '');
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = 'Cancellation failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
}
