import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class Maplocation extends StatefulWidget {
  @override
  _MaplocationState createState() => _MaplocationState();
}

class _MaplocationState extends State<Maplocation> {
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
                  onMapCreated: _onMap,
                  myLocationEnabled: true,
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
}
