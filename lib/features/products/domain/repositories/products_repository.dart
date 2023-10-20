import 'package:teslo_shop_flutter/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  //se definen solo las reglas
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);
  Future<List<Product>> searchProductByTerm(String term);
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
