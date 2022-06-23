part of 'auth_bloc.dart';

enum AuthStatus {
  signedOut,
  signingIn,
  signedIn,
}

class AuthState extends Equatable {

  final bool isInitialized;
  final User? user;
  final AuthStatus authStatus;

  const AuthState({
    this.user,
    this.isInitialized = false,
    this.authStatus = AuthStatus.signedOut
  });

  AuthState copyWith({
    bool? isInitialized,
    User? user,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      isInitialized: isInitialized ?? this.isInitialized,
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
