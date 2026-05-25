import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Stream — automatically updates when user signs in or out
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current logged-in user
  User? get currentUser => _auth.currentUser;

  // Get current user's unique ID
  String? get currentUid => _auth.currentUser?.uid;

  // Register a new user with email and password
  Future<UserCredential> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleError(e);
    }
  }

  // Login existing user
  Future<UserCredential> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleError(e);
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Convert Firebase error codes into readable messages
  String _handleError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
