import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
 

import 'authentication_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthCubit({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance,
      super(const AuthInitial());

  Future<void> checkAuthStatus() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(AuthAuthenticated(currentUser));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(const AuthLoading());
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        emit(const AuthError('Failed to create user'));
        emit(const AuthUnauthenticated());
        return;
      }

      // Save username to Firestore under users/{uid}
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
        'authProvider': 'password',
      }, SetOptions(merge: true));

      // Optionally updateDisplayName
      await user.updateDisplayName(username);

      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseAuthCodeToMessage(e.code)));
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Sign up failed: $e'));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        emit(const AuthError('Failed to sign in'));
        emit(const AuthUnauthenticated());
        return;
      }
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseAuthCodeToMessage(e.code)));
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Sign in failed: $e'));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());
    try {
      UserCredential userCredential;
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider
        ..addScope('email')
        ..setCustomParameters({'prompt': 'select_account'});
      if (kIsWeb) {
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        userCredential = await _auth.signInWithProvider(googleProvider);
      }

      final user = userCredential.user;
      if (user == null) {
        emit(const AuthError('Google sign-in failed'));
        emit(const AuthUnauthenticated());
        return;
      }

      // Persist profile in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': user.displayName ?? '',
        'photoURL': user.photoURL,
        'authProvider': 'google',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseAuthCodeToMessage(e.code)));
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Google sign-in failed: $e'));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading());
    try {
      await _auth.signOut();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Sign out failed: $e'));
      emit(const AuthUnauthenticated());
    }
  }

  String _mapFirebaseAuthCodeToMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already in use';
      case 'invalid-email':
        return 'Invalid email';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'weak-password':
        return 'Weak password';
      case 'user-disabled':
        return 'User disabled';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      case 'popup-closed-by-user':
        return 'Popup closed by user';
      default:
        return 'Authentication error ($code)';
    }
  }
}
