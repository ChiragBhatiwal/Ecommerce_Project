import 'package:equatable/equatable.dart';

abstract class PanelState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialStateLoadingForPanel extends PanelState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingStateForPanel extends PanelState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedStateForPanel extends PanelState {
  int pendingOrders, completedOrders;
  num totalRevenue;
  LoadedStateForPanel(
      {required this.pendingOrders,
      required this.completedOrders,
      required this.totalRevenue});
  @override
  // TODO: implement props
  List<Object?> get props => [pendingOrders, completedOrders, totalRevenue];
}

class FailedToLoadPanelState extends PanelState {
  String error;
  FailedToLoadPanelState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
