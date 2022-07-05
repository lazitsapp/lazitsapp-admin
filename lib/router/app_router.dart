import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/router/app_page.dart';
import 'package:lazitsapp_admin/widget/page/page.dart';

import '../bloc/auth/auth_bloc.dart';
import '../widget/page/category_create_page.dart';

class AppRouter {

  final AuthBloc _authBloc;

  AppRouter(AuthBloc authBloc) : _authBloc = authBloc;

  late final GoRouter _goRouter = GoRouter(
    
    initialLocation: AppPage.home.path,
    
    routes: <GoRoute>[

      // Home
      GoRoute(
        path: AppPage.home.path,
        name: AppPage.home.name,
        builder: (context, state) => const HomePage(),
      ),

      // Error
      GoRoute(
        path: AppPage.error.path,
        name: AppPage.error.name,
        builder: (context, state) => ErrorPage(error: state.extra.toString()),
      ),

      // Login
      GoRoute(
        path: AppPage.login.path,
        name: AppPage.login.name,
        builder: (context, state) => const LoginPage(),
      ),

      // Author
      GoRoute(
        path: AppPage.authorList.path,
        name: AppPage.authorList.name,
        builder: (context, state) => const AuthorListPage(),
        routes: [
          GoRoute(
            path: AppPage.authorUpdate.path,
            name: AppPage.authorUpdate.name,
            builder: (context, state) {
              final String authorId
                = state.params['authorId']!;
              return AuthorUpdatePage(authorId);
            }
          ),
          GoRoute(
            path: AppPage.authorCreate.path,
            name: AppPage.authorCreate.name,
            builder: (context, state) => const AuthorCreatePage()
          )
        ]
      ),

      // Category
      GoRoute(
        path: AppPage.categoryList.path,
        name: AppPage.categoryList.name,
        builder: (context, state) => const CategoryListPage(),
        routes: [
          GoRoute(
            path: AppPage.categoryUpdate.path,
            name: AppPage.categoryUpdate.name,
            builder: (context, state) {
              final String categoryId = state.params['categoryId']!;
              return CategoryUpdatePage(categoryId);
            }
          ),
          GoRoute(
            path: AppPage.categoryCreate.path,
            name: AppPage.categoryCreate.name,
            builder: (context, state) => const CategoryCreatePage()
          )
        ]
      ),

      // Article


    ],

    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),

    redirect: (state) {
      final bool isAuthenticated = _authBloc.state.authStatus == AuthStatus.signedIn;
      final loginLocation = (state.namedLocation(AppPage.login.name));
      final isOnLoginPage = (state.subloc == loginLocation);

      if (isAuthenticated && isOnLoginPage) {
        return state.namedLocation(AppPage.home.name);
      } else if (isAuthenticated == false && isOnLoginPage) {
        return null;
      } else if (isAuthenticated == false && isOnLoginPage == false) {
        debugPrint('redirecting to login');
        return loginLocation;
      } else {
        return null;
      }

    }

  );

  GoRouter get router => _goRouter;

}
