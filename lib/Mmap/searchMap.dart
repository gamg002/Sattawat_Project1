import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helo/Mmap/map_model.dart';
import 'package:helo/Mmap/networkMap.dart';
import 'package:helo/addOn/myURL.dart';
import 'package:helo/widget/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class searchMap extends StatefulWidget {
  @override
  _searchMapState createState() => _searchMapState();
}

class _searchMapState extends State<searchMap> {
  String user, searchmap;
  Timer debouncer;
  TextEditingController searc = TextEditingController();
  @override
  void initState() {
    debouncer?.cancel();
    // TODO: implement initState
    super.initState();
    findUser();
    //init();
  }

  @override
  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  List<map_model> post = List();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
                child: ListView.builder(
                    itemCount: post.length,
                    itemBuilder: (context, index) {
                      final postes = post[index];
                      return buildlist(postes);
                    }))
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => Container(
        width: 300,
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: TextField(
          controller: searc,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            labelText: 'ค้นหา ...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onChanged: searchMap,
        ),
      );
  Widget buildlist(map_model postes) => Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          leading: Icon(Icons.arrow_forward_ios),
          title: Text(postes.name),
          subtitle: Text(postes.other),
          tileColor: Colors.blue[100],
          trailing: Icon(
            Icons.star,
            color: Colors.orange,
          ),
          onTap: () {},
        ),
      );

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = preferences.getString('state');
    readAllOrder();
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
            post.add(model);
          });
        }
      }
    }
  }

  Future searchMap(String searchmap) async => debounce(() async {
        final maps = await networkMap.getPost(searchmap);

        if (!mounted) return;

        setState(() {
          this.searchmap = searchmap;
          this.post = maps;
        });
      });
}
