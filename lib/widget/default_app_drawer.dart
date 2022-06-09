import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultAppDrawer extends StatelessWidget {
  const DefaultAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Lazíts! Admin'),
          ),
          ListTile(
            title: const Text('Authors'),
            onTap: () {
              GoRouter.of(context).go('/authors');
            },
          ),
          ListTile(
            title: const Text('Categories'),
            onTap: () {
              GoRouter.of(context).go('/categories');
            },
          ),
          ListTile(
            title: const Text('Users'),
            onTap: () {
              GoRouter.of(context).go('/Users');
            },
          ),
        ],
      ),
    );
  }
}
