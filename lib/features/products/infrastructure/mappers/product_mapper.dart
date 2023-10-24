import 'package:teslo_shop_flutter/config/constants/environment.dart';
import 'package:teslo_shop_flutter/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop_flutter/features/products/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      slug: json['slug'],
      stock: json['stock'],
      sizes: List<String>.from(json['sizes'].map((item) => item)),
      //List<String>.from(...), lo que significa que el resultado de la operación anterior (el mapeo de la lista) se convierte en una nueva lista de tipo String. Esto crea una nueva lista que contiene los elementos de la lista original, pero ahora se espera que sean del tipo String.
      gender: json['gender'],
      tags: List<String>.from(json['tags'].map((item) => item)),
      images: List<String>.from(json['images'].map((item) =>
          item.startsWith('http')
              ? item
              : '${Environment.apiUrl}/files/product/$item')),
      user: UserMapper.userJsonToEntity(json['user']));
}
