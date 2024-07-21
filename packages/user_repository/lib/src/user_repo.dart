import 'models/models.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;
  Future<MyUser> signup(MyUser user, String password);
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> setUser(MyUser user);
}