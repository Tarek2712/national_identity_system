import 'package:equatable/equatable.dart';
import '../../domain/entities/citizen_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final CitizenEntity citizen;
  const AuthAuthenticated(this.citizen);
  @override
  List<Object?> get props => [citizen];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}