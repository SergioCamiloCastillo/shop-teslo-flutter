import 'package:teslo_shop_flutter/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  //se definen solo las reglas
  Future<List<Product>> getProductsByPageRepository({int limit = 10, int offset = 0});
  Future<Product> getProductByIdRepository(String id);
  Future<List<Product>> searchProductByTermRepository(String term);
  Future<Product> createUpdateProductRepository(Map<String, dynamic> productLike);
}
