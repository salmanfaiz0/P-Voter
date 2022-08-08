import 'package:app_vote/auth_page.dart';
import 'package:app_vote/electionList.dart';
import 'package:app_vote/phone_no.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      // home: const ElectionList(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}
