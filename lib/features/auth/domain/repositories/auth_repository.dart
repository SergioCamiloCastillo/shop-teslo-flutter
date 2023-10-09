import 'package:teslo_shop_flutter/features/auth/domain/domain.dart';

abstract class AuthRepository {
  //repository es quien va a terminar teniendo en la implementacion la definicion del datasource para autenticarnos
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}
