//el state es como quiero que luzca la informacion del estado de este provider

import 'package:riverpod/riverpod.dart';
import 'package:teslo_shop_flutter/features/products/domain/domain.dart';
import 'package:teslo_shop_flutter/features/products/presentation/providers/product_repository_provider.dart';

//pasos para comprender
//1. productsProvider tiene su estado de luce de la manera ProductsState, donde sabre cuales son los productos y demas
//2. este productsProvider tiene su notifier que sirve para determinar cuando estoy cargando, cuando establece los productos, etc
//3 . productsProvider, nos provee el estado de ProductsState, de manera global junto con el notifier, para poder llamar por ej el loadNextPage
//4. cuando es intancia productsProvider, en alguna lugar como se esta usando el ProductsNotifier, este tiene en su contrcutor que cargue el loadNextPage, ya con una data inicial
final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductsNotifier(productsRepository: productsRepository);
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  // se utiliza para gestionar y notificar cambios en el estado representado por ProductsState
  final ProductsRepository productsRepository;
  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    //apenas coja la instancia, lo primero que coge es el loadNextPage
    loadNextPage();
  }
  Future<bool> createOrUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final product =
          await productsRepository.createUpdateProductRepository(productLike);
      final isProductInList =
          state.products.any((element) => element.id == product.id);
      if (!isProductInList) {
        state = state.copyWith(products: [...state.products, product]);
        return true;
      }
      state = state.copyWith(
          products: state.products
              .map((element) => (element.id == product.id) ? product : element)
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);
    final products = await productsRepository.getProductsByPageRepository(
        limit: state.limit, offset: state.offset);
    if (products.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
    }
    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        products: [...state.products, ...products]);
  }
}

//state notifier provider
class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.products = const []});

  ProductsState copyWith(
          {bool? isLastPage,
          int? limit,
          int? offset,
          bool? isLoading,
          List<Product>? products}) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
