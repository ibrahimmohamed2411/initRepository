import 'view_state.dart';

mixin ViewStateMixin {
  ViewState viewState = ViewState.initial;
  void updateViewState(ViewState viewState) {
    this.viewState = viewState;
  }

  bool get isInitial => viewState == ViewState.initial;
  bool get isLoading => viewState == ViewState.loading;
  bool get isError => viewState == ViewState.error;
  bool get isSuccess => viewState == ViewState.success;
}
