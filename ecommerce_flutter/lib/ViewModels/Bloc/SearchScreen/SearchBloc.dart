import 'package:ecommerce_flutter/Models/SearchScreenModels.dart';
import 'package:ecommerce_flutter/Services/Api/SearchScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/SearchScreen/SearchEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/SearchScreen/SearchState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialLoadingSearchProductsState()) {
    on<FetchSearchProductsEvent>((event, emit) async {
      emit(LoadingSearchProductState());

      try {
        List<SearchScreenModel> data = await SearchScreenApis()
            .getProductBySearchParameter(value: event.value);

        emit(LoadedSearchProductsState(data: data));
      } catch (e) {
        emit(ErrorLoadingSearchProductsState(error: e.toString()));
      }
    });
    on<ResetSearchStateEvent>(
      (event, emit) {
        emit(InitialLoadingSearchProductsState());
      },
    );
  }
}
