import 'package:dio/dio.dart';
import 'package:teslo_shop_flutter/config/constants/environment.dart';
import 'package:teslo_shop_flutter/features/products/domain/domain.dart';
import 'package:teslo_shop_flutter/features/products/infrastructure/mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;
  //late porque lo quiero configurar despues

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  @override
  Future<Product> createUpdateProductDatasource(
      Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductByIdDatasource(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPageDatasource(
      {int limit = 10, int offset = 0}) async {
    final response =
        await dio.get<List>('/api/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (var element in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(element));
    }
    return products;
  }

  @override
  Future<List<Product>> searchProductByTermDatasource(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
