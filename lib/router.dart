import 'package:flutter/material.dart';
import 'package:helo/Form/multi_form.dart';
import 'package:helo/Form/usermap.dart';
import 'package:helo/Mmap/searchMap.dart';
import 'package:helo/widget/authen.dart';
import 'package:helo/widget/home.dart';
import 'package:helo/widget/map.dart';
import 'package:helo/widget/read.dart';
import 'package:helo/widget/save.dart';
import 'package:helo/widget/signin.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/signin': (BuildContext context) => Signin(),
  '/Home': (BuildContext context) => Homescreen(),
  '/save1': (BuildContext context) => usermap(),
  '/read': (BuildContext context) => Read(),
  '/map': (BuildContext context) => Maplocation(),
  '/semap': (BuildContext context) => searchMap(),
  '/multi': (BuildContext context) => MultiForm(),
};
