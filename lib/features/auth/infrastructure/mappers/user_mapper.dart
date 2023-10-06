import 'package:teslo_shop_flutter/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
      id: json['id'],
      email: json['email'],
      fullname: json['fullname'],
      roles: List<String>.from(json['roles'].map((role) => role)),
      token: json['token']);
}