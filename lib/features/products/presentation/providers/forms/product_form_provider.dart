import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop_flutter/config/constants/environment.dart';
import 'package:teslo_shop_flutter/features/products/domain/domain.dart';
import 'package:teslo_shop_flutter/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop_flutter/features/shared/shared.dart';

//el provider, proveera el notifier y el state a todo el arbol de widgets
//autodispose,  es que cuando me salgo recupera el estado por defecto
// necesito family porque se requiere el producto

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  //final createUpdateCallback = ref.watch(productsRepositoryProvider).createUpdateProductRepository;
  final createUpdateCallback =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;
  print('llega aquiiiii');
  return ProductFormNotifier(
      product: product, onSubmitCallback: createUpdateCallback);
});

//el notifier mantiene el productformstate y sus cambios
class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(Map<String, dynamic> productLike)?
      onSubmitCallback;

  ProductFormNotifier({this.onSubmitCallback, required Product product})
      : super(ProductFormState(
            id: product.id,
            title: Title.dirty(product.title),
            slug: Slug.dirty(product.slug),
            price: Price.dirty(product.price),
            sizes: product.sizes,
            gender: product.gender,
            inStock: Stock.dirty(product.stock),
            description: product.description,
            tags: product.tags.join(','),
            images: product.images));
  //en el super creo el estado inicial de nuestro ProductFormState, pero como recibo el product
  //la idea de la funcion onSubmitCallback, es que cuando haga el submit del formulario, llame onSubmitCallback, y ahi se valida el formulario, antes de llegar al backend
  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if (state.isFormValid == false) return false;
    if (onSubmitCallback == null) return false;
    //productLike, es el objeto que que enviare al backend
    final productLike = {
      "id": state.id == 'new' ? null : state.id,
      "title": state.title.value,
      "price": state.price.value,
      "description": state.description,
      "slug": state.slug.value,
      "stock": state.inStock.value,
      "sizes": state.sizes,
      "gender": state.gender,
      "tags": state.tags.split(','),
      "images": state.images
          .map((image) =>
              image.replaceAll('${Environment.apiUrl}/files/product/', ''))
          .toList()
    };
    try {
      await onSubmitCallback!(productLike);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _touchedEverything() {
    //verificar todos los campos si estan correctos
    state = state.copyWith(
        isFormValid: Formz.validate([
      Title.dirty(state.title.value),
      Slug.dirty(state.slug.value),
      Price.dirty(state.price.value),
      Stock.dirty(state.inStock.value)
    ]));
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
        title: Title.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value)
        ]));
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
        slug: Slug.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value)
        ]));
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
        price: Price.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(value),
          Stock.dirty(state.inStock.value)
        ]));
  }

  void onStockChanged(int value) {
    state = state.copyWith(
        inStock: Stock.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(value)
        ]));
  }

  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }
}

class ProductFormState {
  final bool? isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState(
      {this.isFormValid = false,
      this.id,
      this.title = const Title.dirty(''),
      this.slug = const Slug.dirty(''),
      this.price = const Price.dirty(0),
      this.sizes = const [],
      this.gender = 'men',
      this.inStock = const Stock.dirty(0),
      this.description = '',
      this.tags = '',
      this.images = const []});
  ProductFormState copyWith(
          {String? tags,
          List<String>? images,
          String? description,
          bool? isFormValid,
          String? id,
          Title? title,
          Slug? slug,
          Price? price,
          List<String>? sizes,
          String? gender,
          Stock? inStock}) =>
      ProductFormState(
          id: id ?? this.id,
          tags: tags ?? this.tags,
          images: images ?? this.images,
          description: description ?? this.description,
          isFormValid: isFormValid ?? this.isFormValid,
          title: title ?? this.title,
          slug: slug ?? this.slug,
          price: price ?? this.price,
          sizes: sizes ?? this.sizes,
          gender: gender ?? this.gender,
          inStock: inStock ?? this.inStock);
}
