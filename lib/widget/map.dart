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
    setState(() {
      getmarkers.add(
        Marker(
            markerId: MarkerId('1'),
            position: LatLng(7.9004, 98.3515),
            infoWindow: InfoWindow(title: 'No1')),
      );
      getmarkers.add(
        Marker(
            markerId: MarkerId('2'),
            position: LatLng(7.9014, 98.3515),
            infoWindow: InfoWindow(title: 'No2')),
      );
    });
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

  final Set<Marker> markers = new Set();
  Set<Marker> getmarkers = {};

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
                  markers: getmarkers,
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
