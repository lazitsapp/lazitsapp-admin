import 'package:flutter/material.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:lazitsapp_admin/widget/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultAppScaffolding(
      body: LoginForm()
    );
  }

}
