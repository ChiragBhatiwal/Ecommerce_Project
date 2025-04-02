import 'package:ecommerce_flutter/Models/AddressScreenModel.dart';
import 'package:equatable/equatable.dart';

abstract class AddressState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialAddressLoadingState extends AddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingUserAddressState extends AddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedUserAddressState extends AddressState {
  List<AddressScreenModel> addresses;

  LoadedUserAddressState({required this.addresses});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FailedStateUserAddress extends AddressState {
  String error;

  FailedStateUserAddress({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
