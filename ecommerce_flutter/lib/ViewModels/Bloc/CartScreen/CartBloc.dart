import 'package:ecommerce_flutter/Models/CartScreenModels.dart';
import 'package:ecommerce_flutter/Services/Api/CartScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/CartScreen/CartEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/CartScreen/CartState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialCartProductState()) {
    on<RequestCartProductsEvent>(
      (event, emit) async {
        emit(ProductLoadingCartScreenState());

        try {
          List<CartScreenModel> productList =
              await CartScreenApis.getCartProducts();

          emit(ProductLoadedCartScreenState(productList: productList));
        } catch (e) {
          emit(ErrorLoadingProductCartScreenState(error: e.toString()));
        }
      },
    );
  }
}
