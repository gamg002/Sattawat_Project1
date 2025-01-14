import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helo/Form/Useproduct.dart';
import 'package:helo/Form/empty_state.dart';
import 'package:helo/Form/form.dart';
import 'package:helo/Form/formDetail.dart';
import 'package:helo/Form/usermap.dart';
import 'package:helo/Mmap/addMarker.dart';
import 'package:helo/Mmap/map_model.dart';
import 'package:helo/addOn/myURL.dart';
import 'package:helo/addOn/normal_dialog.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  String latt, lngg, work;

  List<UserForm> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String towork = ModalRoute.of(context).settings.arguments;
    work = towork;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: TextField(
            decoration: InputDecoration(
                hintText: "$towork",
                hintStyle: TextStyle(color: Colors.white))),
        actions: <Widget>[
          FlatButton(
            child: Text('SAVE'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: users.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'กดปุ่ม + เพื่อเพิ่มสินค้า',
                  message: 'add product',
                ),
              )
            : SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: true,
                  itemCount: users.length,
                  itemBuilder: (_, i) => users[i],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(Useproduct _useproduct) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.useproduct == _useproduct,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _useproduct = Useproduct();
      users.add(UserForm(
        useproduct: _useproduct,
        onDelete: () => onDelete(_useproduct),
      ));
    });
  }

  ///on save forms
  void onSave() async {
    if (users.length > 0) {
      orderuser();
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.useproduct).toList();

        DateTime dateTime = DateTime.now();
        String date = DateFormat('dd-MM-yyyy').format(dateTime);
        String time = DateFormat('HH:mm').format(dateTime);
        String work2;

        List<String> cost = List();
        List<String> unit = List();
        List<String> type = List();
        List<String> sum = List();

        // print('latt = $latt');
        //print('lngg = $lngg');

        for (var model in data) {
          cost.add(model.cost);
          unit.add(model.unit);
          type.add(model.type);

          setState(() {
            work2 = work;
          });
          print('work = $work2');
          //print('lat = $lat');
          //print('lng = $lng');

          int costInt = int.parse(model.cost);
          int unitInt = int.parse(model.unit);
          int sumInt = costInt * unitInt;
          sum.add(sumInt.toString());

          SharedPreferences preferences = await SharedPreferences.getInstance();
          String fname = preferences.getString('fname');

          String url =
              '${MyUrl().domain}/chanthip/where250.php?isAdd=true&date=$date&fname=$fname&work=$work2&type=${model.type}&cost=${model.cost}&unit=${model.unit}&sum=${sumInt.toString()}';
          await Dio().get(url);
        }
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String fname = preferences.getString('fname');

        print(
            'Date = $date,Time = $time,type = $type,cost = $cost, unit = $unit,name = $fname,sum = $sum');

        String url =
            '${MyUrl().domain}/chanthip/addOrder.php?isAdd=true&date=$date&fname=$fname&time=$time&work=$work2&type=$type&cost=$cost&unit=$unit&sum=$sum&lat=$latt&lng=$lngg';
        await Dio().get(url);

        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => formDetail(),
        );
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
        normalDialog(context, 'บันทึกเรียบร้อย');
      }
    }
  }

  void onBack() {
    Navigator.of(context).pushNamed('/Home');
  }

  void orderuser() async {
    String url =
        '${MyUrl().domain}/chanthip/getWhereCostomer1.php?isAdd=true&name=$work';

    Response response = await Dio().get(url);
    //print("res : $response");
    if (response.toString() != 'null') {
      var result = json.decode(response.data);

      for (var map in result) {
        map_model model = map_model.fromJson(map);
        // print("${model.lat}");
        //print("${model.lng}");

        setState(() {
          latt = model.lat;
          lngg = model.lng;
        });
        print("$latt");
        print("$lngg");
      }
    }
  }
}
