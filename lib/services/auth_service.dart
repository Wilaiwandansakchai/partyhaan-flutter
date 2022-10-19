import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<UserCredential> loginEmail(
      {required String email, required String pass});
}

class AuthServiceImpl implements AuthService {
  @override
  Future<UserCredential> loginEmail(
      {required String email, required String pass}) {
    // TODO: implement loginEmail
    throw UnimplementedError();
  }
}
