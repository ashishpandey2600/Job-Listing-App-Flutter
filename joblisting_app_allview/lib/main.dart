import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joblisting_app_allview/presentation/listingScreen.dart';
import 'package:uuid/uuid.dart';

import 'firebase_options.dart';

var uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ListingScreen(),
    );
  }
}
