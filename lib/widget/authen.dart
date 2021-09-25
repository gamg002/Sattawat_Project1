import 'dart:convert';
import 'package:helo/addOn/myURL.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helo/addOn/normal_dialog.dart';
import 'package:helo/widget/home.dart';
import 'package:helo/widget/ueser_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  void initState() {
    super.initState();
    checkPreference();
  }

  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 90.0, 0.0, 0.0),
                          child: Text('CHANTHIPTARA',
                              style: TextStyle(
                                  fontSize: 45.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15.0, 130.0, 0.0, 0.0),
                          child: Text('Drinking Water',
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(200, 60.0, 0.0, 0.0),
                          child: Text('.',
                              style: TextStyle(
                                  fontSize: 150.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 250,
                            child: TextField(
                              onChanged: (value) => user = value.trim(),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.account_circle),
                                  isDense: true,
                                  labelText: 'User',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 250,
                            child: TextField(
                              onChanged: (value) => password = value.trim(),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_rounded),
                                  isDense: true,
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.blueAccent,
                              color: Colors.blue,
                              elevation: 7.0,
                              child: MaterialButton(
                                onPressed: () {
                                  login();
                                },
                                child: Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/signin');
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> checkPreference() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String check = preferences.getString('state');
      if (check == 'admin' || check == 'member') {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => Homescreen(),
        );
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      }
    } catch (e) {}
  }

  Future sign() async {
    var url =
        '${MyUrl().domain}/chanthip/getwhereuser.php?isAdd=true&user=$user';
    try {
      Response response = await Dio().get(url);
      var res = json.decode(response.data);
      //print('data = $res');
      for (var map in res) {
        Usermodel usermodel = Usermodel.fromJson(map);
        if (password == usermodel.password) {
          String state = usermodel.state;

          if (state == 'admin') {
            Fluttertoast.showToast(
                msg: "Admin Login",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20.0);
            loginlist(Homescreen(), usermodel);
          } else if (state == "member") {
            Fluttertoast.showToast(
                msg: "Login ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20.0);
            loginlist(Homescreen(), usermodel);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Login False",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20.0);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Login False",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  Future<Null> loginlist(Widget myWidget, Usermodel usermodel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', usermodel.id);
    preferences.setString('fname', usermodel.fname);
    preferences.setString('lname', usermodel.lname);
    preferences.setString('tel', usermodel.tel);
    preferences.setString('state', usermodel.state);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<Null> login() async {
    if (user == null || user.isEmpty || password == null || password.isEmpty) {
      normalDialog(context, 'โปรดกรอกข้อมูลให้ครบ');
    } else {
      sign();
    }
  }
}
