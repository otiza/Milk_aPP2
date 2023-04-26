import 'package:flutter/material.dart';
import 'package:milk_collection/pages/loading_page.dart';
import 'package:milk_collection/pages/tournee_info.dart';
import 'package:milk_collection/pages/tournee_page.dart';
import 'pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading' ,
      routes:{
        '/loading' : (context) => const LoadinPage(),
        '/login' :(context) => const LoginPage(),
        '/home' : (context) => const Hello(),
      },
    );
  }
}

