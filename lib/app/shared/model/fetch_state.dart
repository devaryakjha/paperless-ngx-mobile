enum FetchState {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == FetchState.initial;
  bool get isLoading => this == FetchState.loading;
  bool get isSuccess => this == FetchState.success;
  bool get isError => this == FetchState.error;
}
