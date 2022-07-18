import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_shared/lazitsapp_shared.dart';

import '../router/app_page.dart';


class DefaultAppEndDrawer extends StatelessWidget {
  const DefaultAppEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prevState, nextState) {
        return (
          prevState.authStatus != AuthStatus.signedOut &&
          nextState.authStatus == AuthStatus.signedOut
        );
      },
      listener: (context, state) {
        GoRouter.of(context).go(AppPage.login.path);
      },
      child: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Log out'),
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(Signout());
                },
              ),
            ],
          )
      ),
    );
  }
}
