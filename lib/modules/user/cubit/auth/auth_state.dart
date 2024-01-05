import 'package:equatable/equatable.dart';

import '../../model/user_mdoel.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthAuthenticatedState extends AuthState {
  final UserModel user;

  const AuthAuthenticatedState({required this.user});

  @override
  String toString() => 'AuthAuthenticated';

  @override
  List<Object?> get props => [user];
}

class AuthUnuauthenticatedState extends AuthState {
  @override
  String toString() => 'AuthUnuauthenticated';

  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  String toString() => 'AuthLoading';

  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final String error;

  const AuthErrorState({required this.error});

  @override
  String toString() => 'Error: $error';

  @override
  List<Object?> get props => [error];
}
