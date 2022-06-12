import 'package:flutter/material.dart';
import 'package:lazitsapp_admin/widget/default_app_drawer.dart';

class DefaultAppScaffolding extends StatelessWidget {

  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;

  const DefaultAppScaffolding(
    {
      required this.body,
      this.floatingActionButton,
      this.drawer = const DefaultAppDrawer(),
      Key? key,
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazíts! Admin'),
      ),
      drawer: drawer,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

}
