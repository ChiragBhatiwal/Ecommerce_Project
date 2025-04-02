import 'package:ecommerce_flutter/Models/AddressScreenModel.dart';
import 'package:ecommerce_flutter/Services/Api/AddressScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/AddressScreen/AddressEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/AddressScreen/AddressState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(InitialAddressLoadingState()) {
    on<RequestUserAddress>(
      (event, emit) async {
        emit(LoadingUserAddressState());

        try {
          List<AddressScreenModel> addresses =
              await AddressScreenApis().getUserAddresses();
          emit(LoadedUserAddressState(addresses: addresses));
        } catch (e) {
          emit(FailedStateUserAddress(error: e.toString()));
        }
      },
    );
  }
}
