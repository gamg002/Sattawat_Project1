import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  @override
  __SigninState createState() => __SigninState();
}

class __SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHANTHIPTARA'),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              nameHead(),
              userPassword(),
              detail(),
              buttonRegis(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameHead() {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
                radius: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 10),
              child: Text(
                'REGISTER MEMBER',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  Widget userPassword() {
    String user, password;
    return Column(
      children: [
        Container(
          width: 250,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.blue[900],
                    size: 45,
                  ),
                  hintText: 'User',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
          ),
        ),
        Container(
          width: 250,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) => user = value.trim(),
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blue[900],
                    size: 45,
                  ),
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
          ),
        )
      ],
    );
  }

  Widget detail() {
    String fname, lname, tel;
    return Column(
      children: [
        Container(
          width: 300,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: TextField(
              onChanged: (value) => fname = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.blue[900],
                  ),
                  hintText: 'ชื่อ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
          ),
        ),
        Container(
          width: 300,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: TextField(
              onChanged: (value) => lname = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.blue[900],
                  ),
                  hintText: 'นามสกุล',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
          ),
        ),
        Container(
          width: 300,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: TextField(
              onChanged: (value) => tel = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.call,
                    color: Colors.blue[900],
                  ),
                  hintText: 'เบอร์มือถือ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
          ),
        ),
      ],
    );
  }

  buttonRegis() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      width: 150,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.blueAccent,
        color: Colors.blue,
        elevation: 7.0,
        child: MaterialButton(
          onPressed: () {},
          child: Center(
            child: Text(
              'Register',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> register() async {}
}
