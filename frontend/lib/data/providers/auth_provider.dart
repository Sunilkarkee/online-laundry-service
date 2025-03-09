import 'package:flutter/foundation.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _currentUser;
  bool _isLoading = false;
  String _error = '';

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;
  String get error => _error;

  AuthProvider() {
    _authService.user.listen((user) {
      _currentUser = user;
      if (user != null) {
        _loadUserData(user.id);
      }
      notifyListeners();
    });
  }

  // Helper method to reduce code duplication in async functions
  Future<bool> _performAuthAction(
    Future<void> Function() action, {
    String? successMessage,
  }) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      await action();
      if (successMessage != null) {
        _error = successMessage; // Set success message or handle
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = 'Error: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Load user data from Firestore
  Future<void> _loadUserData(String userId) async {
    try {
      User? userData = await _firestoreService.getUser(userId);
      _currentUser = userData;
      notifyListeners();
    } catch (e) {
      _error = 'Error loading user data: $e';
      notifyListeners();
    }
  }

  // Sign in
  Future<bool> signIn(String email, String password) async {
    return _performAuthAction(() async {
      User? user = await _authService.signInWithEmailAndPassword(email, password);
      // ignore: unnecessary_null_comparison
      if (user != null) {
        _currentUser = user;
      }
    });
  }

  // Register new user
  Future<bool> register(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    return _performAuthAction(() async {
      User? user = await _authService.registerWithEmailAndPassword(
        email,
        password,
        name,
        phone,
      );
      // ignore: unnecessary_null_comparison
      if (user != null) {
        _currentUser = user;
      }
    });
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    return _performAuthAction(() async {
      await _authService.resetPassword(email);
    });
  }

  // Update user profile
  Future<bool> updateProfile(String name, String phone) async {
    if (_currentUser == null) return false;

    return _performAuthAction(() async {
      User updatedUser = _currentUser!.copyWith(name: name, phone: phone);
      await _firestoreService.updateUser(updatedUser);
      _currentUser = updatedUser;
    });
  }

  // Update user addresses
  Future<bool> updateAddresses(List<Map<String, dynamic>> addresses) async {
    if (_currentUser == null) return false;

    return _performAuthAction(() async {
      User updatedUser = _currentUser!.copyWith(addresses: addresses);
      await _firestoreService.updateUser(updatedUser);
      _currentUser = updatedUser;
    });
  }
}
