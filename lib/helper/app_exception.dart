class AppException implements Exception {
  final _statusCode;
  final _message;
  final _prefix;

  AppException([this._statusCode, this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message$_statusCode";
  }

  int? get statusCode => _statusCode;
  String? get message => _message;
  String? get prefix => _prefix;
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([int? statusCode, String? message])
      : super(statusCode, message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([int? statusCode, String? message])
      : super(statusCode, message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([int? statusCode, String? message])
      : super(statusCode, message, "Invalid Input: ");
}

class ResourceNotFoundException extends AppException {
  ResourceNotFoundException([int? statusCode, String? message])
      : super(statusCode, message, "Resource Not Found: ");
}

class NoInternetException extends AppException {
  NoInternetException([int? statusCode, String? message])
      : super(statusCode, message, "Please checko your internet connection. ");
}
