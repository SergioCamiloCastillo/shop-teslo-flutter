import 'package:teslo_shop_flutter/features/products/domain/entities/product.dart';

abstract class ProductsDatasource {
  //se definen solo las reglas
  Future<List<Product>> getProductsByPageDatasource({int limit = 10, int offset = 0});
  Future<Product> getProductByIdDatasource(String id);
  Future<List<Product>> searchProductByTermDatasource(String term);
  Future<Product> createUpdateProductDatasource(Map<String, dynamic> productLike);
}
