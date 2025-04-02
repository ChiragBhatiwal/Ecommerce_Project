import 'package:ecommerce_flutter/Models/UserInformationModel.dart';
import 'package:equatable/equatable.dart';

abstract class UserInfoState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialLoadingState_UserInfoState extends UserInfoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingState_UserInfoState extends UserInfoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedState_UserInfoState extends UserInfoState {
  UserInformationModel? userInformationModel;
  LoadedState_UserInfoState({required this.userInformationModel});
  @override
  // TODO: implement props
  List<Object?> get props => [userInformationModel];
}

class FailedState_UserInfoState extends UserInfoState {
  String? error;
  FailedState_UserInfoState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
