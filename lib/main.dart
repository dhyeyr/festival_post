import 'dart:math';

import 'package:festival_post/constent.dart';
import 'package:festival_post/views/download_post.dart';
import 'package:festival_post/views/home_screen.dart';
import 'package:festival_post/views/post_detail.dart';
import 'package:festival_post/views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      routes: {
        "/": (context) => SplashScreen(),
       homePage:(context) => HomeScreen(),
        quotepage:(context) => QuotesDetail(map: {}),
        dwn:(context) => CartPage(),
      },
    );
  }
}
