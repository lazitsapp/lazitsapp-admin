import 'package:flutter/material.dart';

class AppbarProfileButton extends StatelessWidget {

  const AppbarProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_circle),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }

}
