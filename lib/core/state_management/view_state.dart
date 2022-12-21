
enum ViewState { initial, loading, error, success }

extension ViewStatus on ViewState {
  bool get isInitial => this == ViewState.initial;
  bool get isLoading => this == ViewState.loading;
  bool get isError => this == ViewState.error;
  bool get isSuccess => this == ViewState.success;
}
