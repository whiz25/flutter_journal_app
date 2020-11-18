part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Anonymous extends AuthState {
  final UserModel user;

  const Anonymous({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Anonymous {userId: ${user.id}}';
}

class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() =>
      'Authenticated {userId: ${user.id}, email: ${user.email}}';
}

class Unauthenticated extends AuthState {}
