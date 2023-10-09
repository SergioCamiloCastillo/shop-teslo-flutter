import 'package:teslo_shop_flutter/features/auth/domain/domain.dart';
import 'package:teslo_shop_flutter/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  //la idea de AuthRepositoryImpl, es que facilmente nos permita hacer los cambios de los datasource, cambiar un metodo de autenticacion por otro
  final AuthDataSource datasource;

  AuthRepositoryImpl({AuthDataSource? datasource})
      : datasource = datasource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return datasource.register(email, password, fullName);
  }
}
