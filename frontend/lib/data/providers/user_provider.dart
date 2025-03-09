import 'package:flutter/foundation.dart';
import '../../services/firestore_service.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  User? _user;
  bool _isLoading = false;
  String _error = '';

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadUserData(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _firestoreService.getUser(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load user data: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<bool> updateProfileDetails({
    required String name,
    required String phone,
    required List<Map<String, dynamic>> addresses,
  }) async {
    if (_user == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = _user!.copyWith(
        name: name,
        phone: phone,
        addresses: addresses,
      );

      await _firestoreService.updateUser(updatedUser);
      _user = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = 'Update failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<void> addAddress(Map<String, dynamic> address) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.addUserAddress(_user!.id, address);
      _user = _user!.copyWith(addresses: [..._user!.addresses, address]);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to add address: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> removeAddress(Map<String, dynamic> address) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.removeUserAddress(_user!.id, address);
      _user = _user!.copyWith(
        addresses: _user!.addresses.where((a) => a != address).toList(),
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to remove address: ${e.toString()}';
      notifyListeners();
    }
  }
}
