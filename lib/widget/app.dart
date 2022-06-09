import 'package:article_repository/article_repository.dart';
import 'package:author_repository/author_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:category_repository/category_repository.dart';

import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:lazitsapp_admin/router/app_router.dart';
import 'package:lazitsapp_admin/widget/page/page.dart';
import 'package:provider/provider.dart';


class LazitsAppAdmin extends StatefulWidget {

  final FirebaseProvider firebaseProvider;

  const LazitsAppAdmin(
    this.firebaseProvider,
    {Key? key}
  ) : super(key: key);

  @override
  State<LazitsAppAdmin> createState() => _LazitsAppAdminState();
}

class _LazitsAppAdminState extends State<LazitsAppAdmin> {

  late final AppRouter appRouter;

  late final AuthenticationRepository authenticationRepository;
  late final AuthorRepository authorRepository;
  late final ArticleRepository articleRepository;
  late final CategoryRepository categoryRepository;


  @override
  void initState() {

    authenticationRepository =
      FirebaseAuthenticationRepository(widget.firebaseProvider.firebaseAuth);
    authorRepository =
      FirebaseAuthorRepository(widget.firebaseProvider.firebaseFirestore);
    articleRepository =
      FirebaseArticleRepository(widget.firebaseProvider.firebaseFirestore);
    categoryRepository =
      FirebaseCategoryRepository(widget.firebaseProvider.firebaseFirestore);

    appRouter = AppRouter(
      FirebaseAuthenticationRepository(widget.firebaseProvider.firebaseAuth)
    );
    super.initState();
  }

  @override
  void dispose() {
    appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<FirebaseProvider>(create: (_) => widget.firebaseProvider),

      ],
      child: MaterialApp.router(
        title: 'Lazíts! Admin',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          /* dark theme settings */
        ),
        routeInformationParser: appRouter.router.routeInformationParser,
        routerDelegate: appRouter.router.routerDelegate,
      )
    );

  }
}


// class LazitsAdminApp extends StatelessWidget {
//
//   final FirebaseProvider firebaseProvider;
//
//   LazitsAdminApp(
//     this.firebaseProvider,
//     {Key? key}
//   ) : super(key: key);
//
//   final GoRouter router = AppRouter().router;
//
//
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//
//     return MultiProvider(
//       providers: [
//         Provider<FirebaseProvider>(create: (_) => firebaseProvider),
//
//       ],
//       child: MaterialApp.router(
//         title: 'Lazíts! Admin',
//         themeMode: ThemeMode.dark,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         darkTheme: ThemeData(
//           brightness: Brightness.dark,
//           /* dark theme settings */
//         ),
//         routeInformationParser: _router.routeInformationParser,
//         routerDelegate: _router.routerDelegate,
//       )
//     );
//
//   }
// }
