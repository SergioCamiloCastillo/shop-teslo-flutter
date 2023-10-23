import 'package:teslo_shop_flutter/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  //el objetivo de ProductsRepositoryImpl es utilizar el datasource de abajo
  final ProductsDatasource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<Product> createUpdateProductRepository(Map<String, dynamic> productLike) {
    return datasource.createUpdateProductDatasource(productLike);
  }

  @override
  Future<Product> getProductByIdRepository(String id) {
    return datasource.getProductByIdDatasource(id);
  }

  @override
  Future<List<Product>> getProductsByPageRepository({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPageDatasource(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTermRepository(String term) {
    return datasource.searchProductByTermDatasource(term);
  }
}
