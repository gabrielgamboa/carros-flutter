class ApiResponse<T> {
  bool? ok;
  String? message;
  T? result;

  ApiResponse.ok(this.result) {
    ok = true;
  }

  ApiResponse.error(this.message) {
    ok = false;
  }
}