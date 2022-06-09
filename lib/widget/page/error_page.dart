import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/router/router_utils.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';

class ErrorPage extends StatelessWidget {

  final String? error;

  const ErrorPage({
    this.error,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppScaffolding(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error ?? ""),
            TextButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.home.toName);
              },
              child: const Text(
                  "Back to Home"
              ),
            ),
          ],
        ),
      ),
    );
  }

}
