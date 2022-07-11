import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazitsapp_auth/lazitsapp_auth.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthenticationRepository _authenticationRepository;
  final ProfileRepository _profileRepository;

  late StreamSubscription _authStateChangeSub;
  late StreamSubscription _userChangeSub;

  /*
    The profile is created while signing in the first time.
    If authStateChange or userChange stream data is received before
    finsihing creating a profile, an error is caused.
    This flag is used to filter the streams when sign in pressed
    and to rely on the signin method results not the change streams.
   */
  bool isSigningIn = false;

  AuthBloc({
    required authenticationRepository,
    required profileRepository,
  }) :
    _authenticationRepository = authenticationRepository,
    _profileRepository = profileRepository,
    super(const AuthState(user: null)) {

    _authStateChangeSub = _authenticationRepository.authStateChange
      .takeWhile((_) => (isSigningIn == false))
      .listen((User? user) {
        add(AuthStateChange(user));
      });

    _userChangeSub = _authenticationRepository.userChange
      .takeWhile((_) => (isSigningIn == false))
      .listen((User? profile) {
      add(UserChange(profile));
    });

    on<InitializeAuth>(_onInitializeAuth);
    on<Signin>(_onSignin);
    on<SigninWithEmailAndPassword>(_onSigninWithEmailAndPassword);
    on<AuthStateChange>(_onAuthStateChange);
    on<UserChange>(_onUserChange);
    on<Signout>(_onSignout);

  }

  void _onInitializeAuth(InitializeAuth event, emit) async {
    User? user = await _authenticationRepository.authStateChange.first;
    if (user != null) {
      emit(state.copyWith(
        user: user,
        authStatus: AuthStatus.signedIn,
        isInitialized: true,
      ));
    } else {
      emit(state.copyWith(
        user: null,
        authStatus: AuthStatus.signedOut,
        isInitialized: true,
      ));
    }
  }

  void _onSignin(Signin event, emit) async {
    try {
      isSigningIn = true;

      emit(state.copyWith(authStatus: AuthStatus.signingIn));

      SigninResult signinResult =
        await _authenticationRepository.signIn(event.authProviderType);

      bool isFirstTime = isFirstSignin(signinResult);
      if (isFirstTime) {
        Profile profile = Profile(
          profileId: signinResult.user.uid,
          displayName: signinResult.user.displayName ?? '',
          email: signinResult.user.email ?? '',
          photoURL: signinResult.user.photoUrl ?? '',
          signupDate: DateTime.now(),
        );
        await _profileRepository.createProfile(profile);
      }

      isSigningIn = false;
      emit(state.copyWith(
        user: signinResult.user,
        authStatus: AuthStatus.signedIn
      ));

      // _analyticsService.logSuccessfulSignin();
    } catch (error) {
      emit(state.copyWith(
        user: null,
        authStatus: AuthStatus.signedOut
      ));

      // FirebaseCrashlytics.instance.recordError(
      //   error,
      //   stackTrace,
      //   reason: 'Unable to sign in'
      // );
    }
  }

  void _onSigninWithEmailAndPassword(SigninWithEmailAndPassword event, emit) async {
    emit(state.copyWith(authStatus: AuthStatus.signingIn));

    try {
      SigninResult signinResult =
        await _authenticationRepository.signInWithEmailAndPassword(
          event.email,
          event.password,
        );

      bool isFirstTime = isFirstSignin(signinResult);
      if (isFirstTime) {
        Profile profile = Profile(
          profileId: signinResult.user.uid,
          displayName: signinResult.user.displayName ?? '',
          email: signinResult.user.email ?? '',
          photoURL: signinResult.user.photoUrl ?? '',
          signupDate: DateTime.now(),
        );

        await _profileRepository.createProfile(profile);
      }

      isSigningIn = false;
      emit(state.copyWith(
        user: signinResult.user,
        authStatus: AuthStatus.signedIn
      ));

    } catch (error) {

      emit(state.copyWith(
        user: null,
        authStatus: AuthStatus.signedOut
      ));

    }

  }

  void _onAuthStateChange(AuthStateChange event, emit) async {
    if (event.user != null) {
      emit(state.copyWith(
        user: event.user,
        authStatus: AuthStatus.signedIn,
      ));
    } else {
      emit(state.copyWith(
        user: event.user,
        authStatus: AuthStatus.signedOut,
      ));
    }
  }

  // TODO: Update relevant profile data when changed
  void _onUserChange(UserChange event, emit) {
    if (event.user == null) {
      emit(state.copyWith(
        user: event.user,
        authStatus: AuthStatus.signedOut,
      ));
    } else {
      emit(state.copyWith(
        user: event.user,
        authStatus: AuthStatus.signedIn,
      ));
    }
  }

  void _onSignout(Signout event, emit) async {

    try {
      await _authenticationRepository.signOut();
      emit(state.copyWith(
        user: null,
        authStatus: AuthStatus.signedOut,
      ));
      // _analyticsService.logSuccessfulSignout();
    } catch (error) {
      // FirebaseCrashlytics.instance.recordError(
      //   error,
      //   stackTrace,
      //   reason: 'Unable to sign out'
      // );
    }

  }

  @override
  Future<void> close() async {
    _authStateChangeSub.cancel();
    _userChangeSub.cancel();

    return super.close();
  }

}
