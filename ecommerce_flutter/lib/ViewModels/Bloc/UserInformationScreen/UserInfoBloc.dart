import 'package:ecommerce_flutter/Models/UserInformationModel.dart';
import 'package:ecommerce_flutter/Services/Api/UserInfoApi.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/UserInformationScreen/UserInfoEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/UserInformationScreen/UserInfoState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(InitialLoadingState_UserInfoState()) {
    on<RequestUserInfoEvent>(
      (event, emit) async {
        try {
          emit(LoadingState_UserInfoState());
          UserInformationModel? userInformationModel =
              await UserInfoApi().getUserPersonalInfo();
          emit(LoadedState_UserInfoState(
              userInformationModel: userInformationModel));
        } catch (e) {
          emit(FailedState_UserInfoState(error: e.toString()));
        }
      },
    );
  }
}
