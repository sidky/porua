class ApiError {
  final int status;
  final String message;

  ApiError(this.status, this.message);
}

class UnauthenticatedError {
}