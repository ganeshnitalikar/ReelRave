import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ree_rave/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ree_rave/controller/auth_controller.dart';
import 'package:ree_rave/firebase_options.dart';
import 'package:ree_rave/views/screens/auth/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) {
      Get.put(AuthController());
    },
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReelRave',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const LoginScreen(),
    );
  }
}
