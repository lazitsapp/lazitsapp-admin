import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/widget/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazíts! Admin'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () => GoRouter.of(context).go('/categories'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.category_rounded),
                  Text('Categories'),
                ]
              )
            ),
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () => GoRouter.of(context).go('/articles'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.category_rounded),
                  Text('Articles'),
                ]
              )
            ),
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () => GoRouter.of(context).go('/users'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.category_rounded),
                  Text('Users'),
                ]
              )
            )
          ]
        )
      )
    );
  }
}

