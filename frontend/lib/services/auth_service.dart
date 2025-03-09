import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/core/utils/constants.dart';
import '../data/models/user.dart' as app_user;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<app_user.User?> get userStream => _auth.authStateChanges().asyncMap(
    (user) => user != null ? _getUserData(user.uid) : null,
  );

  get user => null;

  Future<app_user.User?> _getUserData(String uid) async {
    final doc =
        await _firestore
            .collection(AppConstants.usersCollection)
            .doc(uid)
            .get();
    return doc.exists ? app_user.User.fromMap(doc.data()!, doc.id) : null;
  }

  Future<app_user.User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _getUserData(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw _authErrorMapper(e.code);
    }
  }

  Future<app_user.User?> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = app_user.User(
        id: credential.user!.uid,
        email: email,
        name: name,
        phone: phone,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.id)
          .set(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw _authErrorMapper(e.code);
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  String _authErrorMapper(String code) {
    switch (code) {
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Invalid password';
      case 'email-already-in-use':
        return 'Email already registered';
      default:
        return 'Authentication failed';
    }
  }

  resetPassword(String email) {}

  registerWithEmailAndPassword(String email, String password, String name, String phone) {}

  signInWithEmailAndPassword(String email, String password) {}
}
