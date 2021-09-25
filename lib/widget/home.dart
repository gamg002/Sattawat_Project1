import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helo/addOn/normal_dialog.dart';
import 'package:helo/widget/authen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String fname, lname, state;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      lname = preferences.getString('lname');
      state = preferences.getString('state');
      fname = preferences.getString('fname');
    });
  }

  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('CHANTHIPTARA'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue[900]),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.pimacountyfair.com/wp-content/uploads/2016/07/user-icon-6.png",
                            scale: 1.0),
                        radius: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$fname $lname',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight + Alignment(0, .3),
                      child: Text(
                        '($state)',
                        style:
                            TextStyle(fontSize: 13, color: Colors.green[200]),
                      ),
                    )
                  ],
                )),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shadowColor: Colors.blue[600],
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Edit User',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  tileColor: Colors.blue[700],
                  onTap: () {
                    if (state == 'admin') {
                    } else {
                      normalDialog(context, 'เฉพาะ Admin เท่านั้น');
                    }
                  },
                ),
              ),
            ),
            //SizedBox(height: 5.0),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shadowColor: Colors.blue[600],
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 2.5, 10, 0.0),
                child: ListTile(
                  leading: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Log out',
                    style: TextStyle(fontSize: 18, color: Colors.red[100]),
                  ),
                  tileColor: Colors.blue[700],
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "Log out",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red[700],
                        textColor: Colors.white,
                        fontSize: 20.0);
                    logout();
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => Authen(),
                    );
                    Navigator.pushAndRemoveUntil(
                        context, route, (route) => false);
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 0.0),
            child: Text('Menu',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          Card(
              //padding: EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 10.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shadowColor: Colors.blue[600],
              child: MaterialButton(
                  color: Colors.blue[100],
                  onPressed: () {
                    Navigator.of(context).pushNamed('/save');
                  },
                  child: Row(children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/notepad.png'),
                        ),
                      ),
                    ),
                    Container(
                      child: Text('บันทึกข้อมูล',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),
                  ]))),
          Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              //padding: EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 10.0),
              child: MaterialButton(
                  color: Colors.blue[100],
                  onPressed: () {
                    Navigator.of(context).pushNamed('/read');
                  },
                  child: Row(children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/notepad.png'),
                        ),
                      ),
                    ),
                    Container(
                      child: Text('ตรวจสอบข้อมูล',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),
                  ]))),
        ],
      ),
    );
  }
}
