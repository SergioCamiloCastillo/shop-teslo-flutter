import 'package:teslo_shop_flutter/features/auth/domain/domain.dart';

abstract class AuthDataSource {
  //aqui se define que funciones tendre en cuenta para la autorizacion, solamente las mencionamos
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}
