import 'package:flutter/material.dart';

import 'Screens/LoginForm.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHOP CARS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginForm(),
    );
  }
}
