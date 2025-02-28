import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:upgrader/upgrader.dart';

import 'Admin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        title: 'Flutter Demo',
        theme: ThemeData(
        fontFamily: "PoetsenOne-Regular",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: UpgradeAlert(child: const Admin())
      ),
    );
  }
}