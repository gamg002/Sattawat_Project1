import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helo/Mmap/map_model.dart';
import 'package:helo/addOn/myURL.dart';
import 'package:helo/addOn/normal1.dart';
import 'package:helo/search/post.dart';
import 'package:helo/widget/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class test12 extends StatefulWidget {
  final Post post;
  test12(this.post);

  @override
  _test12State createState() => _test12State(post);
}

class _test12State extends State<test12> {
  final Post post;
  _test12State(this.post);
  map_model mapModel;
  String user;
  int totalInts = 0;
  int indexlist = 0;
  final List<List<String>> listType = List();
  final List<List<String>> listCost = List();
  final List<List<String>> listUnit = List();
  final List<List<String>> listSum = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.work + '   ' + post.date),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildState(),
            buildname(),
            buildTime(),
            buildTable(),
            buildOrder(post),
            buildTotal(),
            buildTran(),
            buildMap(),
            finishBotton(),
          ],
        ),
      ),
    );
  }

  Widget buildTime() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'วันที่ : ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          post.date,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'เวลา : ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          post.time,
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget buildname() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(
            'ชื่อ  ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(
            'น้ำดื่มจันทร์ทิพย์ธารา',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }

  Container buildTable() {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(color: Colors.blue),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'ชนิดสินค้า',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'ราคา',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'จำนวน',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'รวมราคา',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = preferences.getString('state');
    readAllOrder();
  }

  List<Marker> myMarker = [];

  Future<Null> readAllOrder() async {
    if (user != null) {
      List<String> Type = changeArrey(post.type);
      List<String> Cost = changeArrey(post.cost);
      List<String> Unit = changeArrey(post.unit);
      List<String> Sum = changeArrey(post.sum);

      int total = 0;
      for (var string in Sum) {
        total = total + int.parse(string.trim());
      }

      setState(() {
        listType.add(Type);
        listCost.add(Cost);
        listUnit.add(Unit);
        listSum.add(Sum);
        totalInts = total;
        //print('total = $totalInts');
      });
    }
    setState(() {
      myMarker.add(Marker(
        markerId: MarkerId(post.idOrder),
        position: LatLng(double.parse(post.lat), double.parse(post.lng)),
      ));
    });
  }

  List<String> changeArrey(String string) {
    List<String> list = List();
    String myString = string.substring(1, string.length - 1);
    //print('myString = $myString');
    list = myString.split(',');
    int index = 0;
    for (var string in list) {
      list[index] = string.trim();
      index++;
    }
    setState(() {
      indexlist = index;
    });
    //print('list *****=>> $list');
    //print('count = $indexlist , index = $index');
    return list;
  }

  Widget buildOrder(Post post) => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: indexlist,
        itemBuilder: (context, index2) => Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Text(
                listType[0][index2],
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                listCost[0][index2],
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                listUnit[0][index2],
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                listSum[0][index2],
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      );

  Widget buildTotal() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(10),
        //decoration: BoxDecoration(color: Colors.grey),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'รวม',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '$totalInts บาท',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildState() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/logo.png'),
            radius: 60,
          ),
        ),
      ],
    );
  }

  Widget buildTran() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 5),
            child: Text(
              'ผู้ส่ง',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
            child: Text(
              post.fname,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Container buildMap() {
    Position userLocation;
    GoogleMapController mapController;
    void _onMap(GoogleMapController controller) {
      mapController = controller;
    }

    Future<Position> _getLocation() async {
      try {
        userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
      } catch (e) {
        userLocation = null;
      }
      return userLocation;
    }

    return Container(
      height: 300,
      child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                  mapType: MapType.normal,
                  //onLongPress: _getAdd,
                  onMapCreated: _onMap,
                  myLocationEnabled: true,
                  markers: Set.from(myMarker),
                  //markers: Set.from(myMarker),
                  initialCameraPosition: CameraPosition(
                      target:
                          LatLng(userLocation.latitude, userLocation.longitude),
                      zoom: 18));
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          }),
    );
  }

  Widget finishBotton() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
          color: Colors.green,
          onPressed: () {
            normal1(context, "ทำการส่งของเรียบร้อยแล้ว ?");
          },
          icon: Icon(
            Icons.add_moderator,
            color: Colors.white,
          ),
          label: Text(
            'เรียบร้อย',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
