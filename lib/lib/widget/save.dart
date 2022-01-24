import 'package:flutter/material.dart';
import 'package:helo/Form/multi_form.dart';
import 'package:helo/router.dart';

class Save extends StatefulWidget {
  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, routes: routes, home: MultiForm());
  }
}
