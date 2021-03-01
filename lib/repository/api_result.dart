class ApiResult<T> {
  final Status status;
  T data;
  String message;
  ApiException error;

  ApiResult.loading([this.message]) : status = Status.LOADING;

  ApiResult.completed(this.data) : status = Status.COMPLETED;

  ApiResult.error(this.error, [this.message]) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

///API 에서 error 가 반환 됐을 때 사용하는 exception
class ApiException implements Exception {
  final dynamic error;
  String _code;

  ApiException(this.error) {
    _code = error['code'];
  }

  String get code => _code;

  @override
  String toString() {
    return 'ApiException($_code)';
  }
}
