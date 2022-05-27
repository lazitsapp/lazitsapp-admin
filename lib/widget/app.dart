import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/widget/page/page.dart';

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesPage(),
      ),
      GoRoute(
        path: '/articles',
        builder: (context, state) => const ArticlesPage(),
      ),
      GoRoute(
        path: '/users',
        builder: (context, state) => const UsersPage(),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Lazíts! Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Lazíts! Admin'),
    //   ),
    //   body:
    // );

  }
}
