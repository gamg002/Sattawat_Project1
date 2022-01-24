import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helo/addOn/myURL.dart';
import 'package:helo/addOn/normal_dialog.dart';
import 'package:helo/widget/map.dart';

String name, other, lat, lng;

void registerThread(BuildContext context, LatLng Point) async {
  String url =
      '${MyUrl().domain}/chanthip/addCuster.php?isAdd=true&name=$name&other=$other&Lat=${Point.latitude}&Lng=${Point.longitude}';

  try {
    Response response = await Dio().get(url);
    print('res = $response');

    if (response.toString() == 'true') {
      MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => Maplocation(),
      );
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {
      normalDialog(context, "เกิดข้อผิดพลาด");
    }
  } catch (e) {}
}

Future<Null> check(BuildContext context, LatLng Point) {
  if (name == null || name.isEmpty || other == null || other.isEmpty) {
    normalDialog(context, "มีส่วนที่ยังไม่ได้กรอกข้อมูล");
  } else {
    registerThread(context, Point);
  }
}

Future<void> Addmarker(BuildContext context, LatLng Point) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text("AddMarker"),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_balance_sharp),
                  isDense: true,
                  labelText: 'ชื่อร้าน'),
            ),
            TextField(
              onChanged: (value) => other = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.paste_sharp),
                  isDense: true,
                  labelText: 'รายละเอียด'),
            ),
            TextField(
              onChanged: (value) => lat = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.maps_ugc),
                  isDense: true,
                  labelText: '${Point.latitude}'),
            ),
            TextField(
              onChanged: (value) => lng = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.maps_ugc_outlined),
                  isDense: true,
                  labelText: '${Point.longitude}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                    padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
                    onPressed: () => check(context, Point),
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Colors.green),
                    )),
                FlatButton(
                    padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            )
          ],
        )
      ],
    ),
  );
}
