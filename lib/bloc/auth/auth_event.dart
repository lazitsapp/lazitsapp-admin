part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class Signin extends AuthEvent {

  final AuthProviderType authProviderType;

  const Signin(this.authProviderType);

  @override
  List<Object?> get props => [authProviderType];

}

class SigninWithEmailAndPassword extends AuthEvent {

  final String email;
  final String password;

  const SigninWithEmailAndPassword(
    this.email, this.password,
  );

  @override
  List<Object?> get props => [email, password];

}

class Signout extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthStateChange extends AuthEvent {

  final User? user;

  const AuthStateChange(this.user);

  @override
  List<Object?> get props => [user];
}

class UserChange extends AuthEvent {

  final User? user;

  const UserChange(this.user);

  @override
  List<Object?> get props => [user];

}
