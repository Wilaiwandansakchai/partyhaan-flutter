import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user_model.dart';

abstract class AuthService {
  Future<void> signup({required String email, required String password});

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<void> logOut();

  Stream<User> get user;

}

class AuthServiceImpl implements AuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthServiceImpl({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;


  @override
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  @override
  Future<void> signup({required String email, required String password}) {
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {
      throw "";
    }
  }

  @override
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) {
    try {
      return _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {
      throw "";
    }
  }

  @override
  Future<void> logOut() {
    try {
      return Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {
      throw "";
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
