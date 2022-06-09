part of 'auth_bloc.dart';

enum AuthStatus {
  signedOut,
  signingIn,
  signedIn,
}

class AuthState extends Equatable {

  final User? user;
  final AuthStatus authStatus;

  const AuthState({
    this.user,
    this.authStatus = AuthStatus.signedOut
  });

  AuthState copyWith({
    User? user,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  bool get isAuthenticated {
    return (authStatus == AuthStatus.signedIn);
  }

  @override
  List<Object?> get props => [
    user,
    authStatus,
  ];
}
