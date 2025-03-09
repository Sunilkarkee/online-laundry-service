class AppConstants {
  static const String appName = 'Laundry Pro';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String servicesCollection = 'services';
  static const String ordersCollection = 'orders';

  // Storage Paths
  static const String userAvatarsPath = 'user_avatars';

  // Default Values
  static const double deliveryFee = 5.99;
  static const int defaultServiceDuration = 24; // hours
}

class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String checkout = '/checkout';
  static const String orderDetail = '/order-detail';
}
