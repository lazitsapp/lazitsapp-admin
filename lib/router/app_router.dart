import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/bloc/auth/auth_bloc.dart';
import 'package:lazitsapp_admin/router/router_utils.dart';
import 'package:lazitsapp_admin/widget/page/page.dart';

class AppRouter {

  GoRouter get router => _goRouter;

  final AuthenticationRepository _authentitactionRepository;

  bool isAuthenticated = false;
  late StreamSubscription _authStateSub;

  AppRouter(AuthenticationRepository authenticationRepository) :
    _authentitactionRepository = authenticationRepository {

    _authStateSub = _authentitactionRepository
      .authStateChange
      .listen((User? user) {
        if (user != null) {
          isAuthenticated = true;
        } else {
          isAuthenticated = false;
        }
      });

  }

  void dispose() {
    _authStateSub.cancel();
  }

  late final GoRouter _goRouter = GoRouter(

    // refreshListenable: appService,
    
    initialLocation: AppPage.home.toPath,
    
    routes: <GoRoute>[

      // Home
      GoRoute(
        path: AppPage.home.toPath,
        name: AppPage.home.toName,
        builder: (context, state) => const HomePage(),
      ),

      // Error
      GoRoute(
        path: AppPage.error.toPath,
        name: AppPage.error.toName,
        builder: (context, state) => ErrorPage(error: state.extra.toString()),
      ),

      // Login
      GoRoute(
        path: AppPage.login.toPath,
        name: AppPage.login.toName,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: AppPage.authors.toPath,
        name: AppPage.authors.toName,
        builder: (context, state) => const AuthorListPage(),
        routes: [
          GoRoute(
            path: AppPage.authorUpdate.toPath,
            name: AppPage.authorUpdate.toName,
            builder: (context, state) {
              final String authorId
                = state.params['authorId']!;
              return AuthorUpdatePage(authorId);
            }
          ),
          // GoRoute(
          //   path: AppPage.authorCreate.toPath,
          //   name: AppPage.authorCreate.toName,
          //   builder: (context, state) {
          //
          //   }
          // )
        ]
      ),


    ],

    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),

    redirect: (state) {
      final loginLocation = state.namedLocation(AppPage.login.toName);
      final isOnLoginPage = state.subloc == loginLocation;


      if (isAuthenticated == false && isOnLoginPage == false) {
        return loginLocation;
      } else {
        return null;
      }
    }

  );

}
