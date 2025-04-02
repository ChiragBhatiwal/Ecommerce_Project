import 'package:ecommerce_flutter/Services/Api/PanelApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/PanelState/PanelEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/PanelState/PanelState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanelBloc extends Bloc<PanelEvent, PanelState> {
  PanelBloc() : super(InitialStateLoadingForPanel()) {
    on<RequestPanelData>(
      (event, emit) async {
        try {
          emit(LoadingStateForPanel());
          final data = await PanelApis().getPanelDetails();

          final pendingOrders = data["data"]["Others"];
          final completedOrders = data["data"]["Delivered"];
          final totalRevenue = data["data"]["revenue"];

          emit(LoadedStateForPanel(
              pendingOrders: pendingOrders,
              completedOrders: completedOrders,
              totalRevenue: totalRevenue));
        } catch (e) {
          emit(FailedToLoadPanelState(e.toString()));
        }
      },
    );
  }
}
