import 'package:lazitsapp_auth/lazitsapp_auth.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/bloc/auth/auth_bloc.dart';
import 'package:lazitsapp_admin/router/app_router.dart';
import 'package:lazitsapp_admin/widget/app_initializer.dart';
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

  late final AuthBloc authBloc;
  late final AppRouter appRouter;

  late final AuthenticationRepository authenticationRepository;
  late final AuthorRepository authorRepository;
  late final ArticleRepository articleRepository;
  late final CategoryRepository categoryRepository;
  late final ProfileRepository profileRepository;

  @override
  void initState() {

    authenticationRepository =
      FirebaseAuthenticationRepository(
        widget.firebaseProvider.auth,
        persistence: Persistence.LOCAL,
      );
    authorRepository =
      FirebaseAuthorRepository(widget.firebaseProvider.firestore);
    articleRepository =
      FirebaseArticleRepository(widget.firebaseProvider.firestore);
    categoryRepository =
      FirebaseCategoryRepository(widget.firebaseProvider.firestore);
    profileRepository =
      FirebaseProfileRepository(widget.firebaseProvider.firestore);

    authBloc = AuthBloc(
      authenticationRepository: authenticationRepository,
      profileRepository: profileRepository,
    );
    appRouter = AppRouter(authBloc);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<FirebaseProvider>(create: (_) => widget.firebaseProvider),
      ],
      child: BlocProvider<AuthBloc>(
          create: (BuildContext context) => authBloc..add(const InitializeAuth()),
          child: AppInitializer(
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
              supportedLocales: const [Locale('en')],
              localizationsDelegates: const [
                FormBuilderLocalizations.delegate
              ],
            ),
          )
      )
    );

  }
}
