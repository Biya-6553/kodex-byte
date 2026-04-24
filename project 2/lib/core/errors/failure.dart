abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection');
}

class TimeoutFailure extends Failure {
  const TimeoutFailure() : super('Request timed out');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Session expired');
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.msg);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super('Something went wrong');
}
