import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthServiceImpl _apiService = AuthServiceImpl();
  var currentUser = User.empty;

  Stream<User> get user {
    return _apiService.user;
  }

  Future<void> signup({required String email, required String password}) async {
     return _apiService.signup(email: email, password: password);
  }

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
   return _apiService.loginWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logOut() async {
    return _apiService.logOut();
  }
}
