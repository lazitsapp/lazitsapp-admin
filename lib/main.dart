import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lazitsapp_admin/widget/app.dart';
import 'firebase_options.dart';

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseProvider firebaseProvider = FirebaseProvider();
  const bool useLocalFirestore = bool.fromEnvironment('USE_LOCAL_FIREBASE');
  if (useLocalFirestore) {
    await firebaseProvider.useEmulator();
  }

  runApp(LazitsAppAdmin(firebaseProvider));
}
