import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class BiometricFailure extends Failure {
  final String message;
  const BiometricFailure(this.message);

  @override
  List<Object?> get props => [message];
}