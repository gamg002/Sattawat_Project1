import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:helo/Form/Useproduct.dart';
import 'package:helo/Form/latlng_model.dart';
import 'package:helo/Form/multi_form.dart';
import 'package:helo/Mmap/map_model.dart';
import 'package:helo/addOn/myURL.dart';
import 'package:helo/addOn/normal_dialog.dart';
import 'package:helo/widget/save.dart';
import 'package:shared_preferences/shared_preferences.dart';

class usermap extends StatefulWidget {
  const usermap({Key key}) : super(key: key);
  @override
  State<usermap> createState() => _usermapState();
}

class _usermapState extends State<usermap> {
  String mapuser_id, user, data;
  List<String> post = List();
  List<String> modd = List();
  String work = "";
  String latt = "";
  String lngg = "";

  @override
  void initState() {
    findUser();

    // TODO: implement initState
    super.initState();
  }

  Future<Null> readAllOrder() async {
    if (user != null) {
      String url = '${MyUrl().domain}/chanthip/getWhereCostomer.php?isAdd=true';

      Response response = await Dio().get(url);
      //print('data = $response');
      if (response.toString() != 'null') {
        var result = json.decode(response.data);
        for (var map in result) {
          map_model model = map_model.fromJson(map);

          setState(() {
            modd.add(model.name);
          });
        }
      }
    }
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = preferences.getString('state');
    readAllOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'เลือกสถานที่ส่ง',
                  style: TextStyle(fontSize: 20),
                ),
              )),
              DropDownField(
                //controller: work,
                onValueChanged: (value) {
                  setState(() {
                    mapuser_id = value;
                  });
                },
                value: mapuser_id,
                strict: true,

                hintText: 'ชื่องาน',
                items: modd,
              ),
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  if (mapuser_id.length != 0) {
                    Navigator.of(context)
                        .pushNamed('/multi', arguments: mapuser_id);
                  }
                },
                child: Text('Next', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
