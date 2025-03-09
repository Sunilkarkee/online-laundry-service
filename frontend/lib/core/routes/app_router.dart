import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/checkout_screen.dart';
import 'package:frontend/presentation/screens/home_screen.dart';
import 'package:frontend/presentation/screens/login_screen.dart';
import 'package:frontend/presentation/screens/orderdetail_screen.dart';
import 'package:frontend/presentation/screens/profile_screen.dart';
import 'package:frontend/presentation/screens/registration_screen.dart';
import 'package:frontend/presentation/screens/service_list_screen.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/services':
        return MaterialPageRoute(
          builder:
              (_) => ServiceListScreen(category: settings.arguments as String),
        );
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case '/order-details':
        return MaterialPageRoute(
          builder:
              (_) => OrderDetailScreen(orderId: settings.arguments as String),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
