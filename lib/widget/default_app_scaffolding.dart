import 'package:flutter/material.dart';
import 'package:lazitsapp_admin/widget/app_bar_profile_button.dart';
import 'package:lazitsapp_admin/widget/default_app_drawer.dart';
import 'package:lazitsapp_admin/widget/default_app_end_drawer.dart';

class DefaultAppScaffolding extends StatelessWidget {

  final Widget body;
  final String title;
  final Widget? drawer;
  final Widget? floatingActionButton;

  const DefaultAppScaffolding(
    {
      required this.body,
      this.title = 'Lazíts! Admin',
      this.drawer = const DefaultAppDrawer(),
      this.floatingActionButton,
      Key? key,
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Text(title),
          actions: const [
            AppbarProfileButton()
          ],
        ),
      ),
      // appBar: DefaultAppBar(
      //   title: Text('title'),
      // ),
      drawer: drawer,
      body: body,
      endDrawer: const DefaultAppEndDrawer(),
      floatingActionButton: floatingActionButton,
    );
  }

}
