enum Status { loading, success, error, loaded }

extension XStatus on Status {
  bool isLoading() => this == Status.loading;
  bool isSuccess() => this == Status.success;
  bool isError() => this == Status.error;
  bool isLoaded() => this == Status.loaded;
}
