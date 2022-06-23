import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

class AppInitializer extends StatelessWidget {

  final Widget child;

  const AppInitializer({
    required this.child,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        if (state.isInitialized) {
          return child;
        } else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }

      }
    );
  }
}



//
// class AppInitializer extends StatefulWidget {
//
//   final Widget child;
//
//   const AppInitializer({
//     required this.child,
//     Key? key
//   }) : super(key: key);
//
//   @override
//   State<AppInitializer> createState() => _AppInitializerState();
// }
//
// class _AppInitializerState extends State<AppInitializer> {
//
//   bool isInitializing = true;
//
//   @override
//   void initState() {
//     isInitializing = true;
//     init();
//     super.initState();
//   }
//
//   Future<void> init() async {
//     // await widget.authRepository.getUser();
//     // setState(() {
//     //   isInitializing = false;
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     if (isInitializing) {
//       return const Center(
//         child: CircularProgressIndicator()
//       );
//     } else {
//       return widget.child;
//     }
//
//   }
//
// }
