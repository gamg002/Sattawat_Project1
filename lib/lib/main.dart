import 'package:flutter/material.dart';
import 'package:helo/router.dart';
import 'package:helo/widget/authen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: Authen(),
    );
  }
}
