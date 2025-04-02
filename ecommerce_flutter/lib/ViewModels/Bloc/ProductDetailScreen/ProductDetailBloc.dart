import 'package:ecommerce_flutter/Models/ProductDetailScreenModel.dart';
import 'package:ecommerce_flutter/Services/Api/ProductDetailScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ProductDetailScreen/ProductDetailEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ProductDetailScreen/ProductDetailState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc()
      : super(InitialProductLoadingStateProductDetailsScreen()) {
    on<FetchProductDetails>(
      (event, emit) async {
        emit(InitialProductLoadingStateProductDetailsScreen());

        try {
          ProductDetailScreenModel data =
              await ProductDetailScreenApi.itemDetails(event.id);
          emit(LoadedProductStateProductDetailScreen(data: data));
        } catch (e) {
          emit(ErrorLoadingProductDetailScreen(error: e.toString()));
        }
      },
    );
  }
}
