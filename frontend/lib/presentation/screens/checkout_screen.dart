import 'package:flutter/material.dart';
import 'package:frontend/data/models/custom_order.dart' show CustomOrder;
import 'package:frontend/data/providers/cart_provider.dart' show CartProvider;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart' show Provider;

class CheckoutScreen extends StatelessWidget {
  final Logger logger = Logger();

  CheckoutScreen({super.key}); // ✅ Use logger instead of print

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Column(
        children: [
          Text('Total: \$${cart.total.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              final newOrder = CustomOrder(
                userId: 'user-id-placeholder', // Replace with actual user ID
                services: cart.services, // ✅ Fixed reference
                pickupDate: DateTime.now(),
                deliveryDate: DateTime.now().add(Duration(days: 2)),
                total: cart.total,
                status: 'pending',
                createdAt: DateTime.now(),
              );

              // ✅ Use logger instead of print
              logger.i('Order placed: ${newOrder.toMap()}');

              // TODO: Send `newOrder` to Firestore or backend
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
