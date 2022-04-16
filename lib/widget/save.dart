import 'package:flutter/material.dart';
import 'package:helo/Form/multi_form.dart';
import 'package:helo/router.dart';

class Save extends StatefulWidget {
  String work, latt, lngg;
  Save(String work, String latt, String lngg) {
    this.work = work;
    this.latt = latt;
    this.lngg = lngg;
  }
  @override
  _SaveState createState() => _SaveState(work, latt, lngg);
}

class _SaveState extends State<Save> {
  String work, latt, lngg;
  _SaveState(String work, String latt, String lngg) {
    this.work = work;
    this.latt = latt;
    this.lngg = lngg;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, routes: routes, home: MultiForm());
  }
}
