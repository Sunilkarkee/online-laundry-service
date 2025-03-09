import 'package:flutter/foundation.dart';
import '../models/service.dart';

class CartProvider with ChangeNotifier {
  final List<Service> _cartItems = [];
  final double _deliveryFee = 5.99;
  bool _isLoading = false;

  // Getters
  List<Service> get cartItems => _cartItems; // Use this in CheckoutScreen
  double get subtotal =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  double get total => subtotal + _deliveryFee;
  bool get isLoading => _isLoading;
  int get itemCount => _cartItems.length;

  // Fix: Adding 'services' getter to match CheckoutScreen
  List<Service> get services =>
      _cartItems; // ✅ Now CheckoutScreen can use cart.services

  void addToCart(Service service) {
    final index = _cartItems.indexWhere((item) => item.id == service.id);
    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
    } else {
      _cartItems.add(service);
    }
    notifyListeners();
  }

  void removeFromCart(String serviceId) {
    _cartItems.removeWhere((item) => item.id == serviceId);
    notifyListeners();
  }

  void updateQuantity(String serviceId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.id == serviceId);
    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  Future<void> simulatePaymentProcessing() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
  }
}
