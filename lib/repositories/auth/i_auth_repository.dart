import '../../models/user/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> loginAnonymously();
  Future<UserModel> loginWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(String email, String password);
  Future<UserModel> logout();
  Future<bool> isAnonymous();
  Future<UserModel> getCurrentUser();
}
