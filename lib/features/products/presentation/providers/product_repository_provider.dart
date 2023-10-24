//el objetivo es establecer a lo largo de mi app, toda la instancia de productrepositoryimpl y tomar ese repositorio
//ese productrepositoryimpl pide en el constructor el productdatasourceimpl



import 'package:riverpod/riverpod.dart';
import 'package:teslo_shop_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop_flutter/features/products/domain/domain.dart';
import 'package:teslo_shop_flutter/features/products/infrastructure/infrastructure.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';
  //tenemos que retornar la instancia
  final productsRepository =
      ProductsRepositoryImpl(ProductsDatasourceImpl(accessToken: accessToken));
  return productsRepository;
});
