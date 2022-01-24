import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:helo/Mmap/addMarker.dart';
import 'package:helo/Mmap/map_model.dart';
import 'package:helo/addOn/myURL.dart';

class Maplocation extends StatefulWidget {
  @override
  _MaplocationState createState() => _MaplocationState();
}

class _MaplocationState extends State<Maplocation> {
  Position userLocation;
  GoogleMapController mapController;
  map_model mapModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadDataCus();
  }

  Future<Null> ReadDataCus() async {
    String url = '${MyUrl().domain}/chanthip/getWhereCostomer.php?isAdd=true';
    await Dio().get(url).then((value) {
      var result = jsonDecode(value.data);
      for (var map in result) {
        mapModel = map_model.fromJson(map);

        setState(() {
          myMarker.add(
            Marker(
                markerId: MarkerId(mapModel.id),
                position: LatLng(
                    double.parse(mapModel.lat), double.parse(mapModel.lng)),
                infoWindow:
                    InfoWindow(title: mapModel.name, snippet: mapModel.other)),
          );
        });
      }
    });
  }

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

  List<Marker> myMarker = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Map'),
      ),
      body: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                  mapType: MapType.normal,
                  onLongPress: _getAdd,
                  onMapCreated: _onMap,
                  myLocationEnabled: true,
                  markers: Set.from(myMarker),
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

  _getAdd(LatLng Point) {
    Addmarker(context, Point);
  }
}
