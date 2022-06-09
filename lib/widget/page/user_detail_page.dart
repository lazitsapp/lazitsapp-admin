import 'package:flutter/material.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';

class UserDetailPage extends StatelessWidget {

  final String userId;

  const UserDetailPage(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppScaffolding(
      body: Container()
    );
  }
}
