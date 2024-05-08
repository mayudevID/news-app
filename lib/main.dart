// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/pages/list_news_page.dart';
import 'package:news_app/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool("isLogin") ?? false;
  if (kDebugMode) {
    print("LOGIN: $isLogin");
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp(isLogin: isLogin)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: (isLogin == true) ? const ListNewsPage() : const LoginPage(),
    );
  }
}
