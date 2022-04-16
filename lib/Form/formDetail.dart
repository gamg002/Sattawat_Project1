import 'dart:async';
import 'dart:convert';
import 'package:helo/Form/test12.dart';
import 'package:helo/addOn/myURL.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helo/search/network.dart';
import 'package:helo/search/post.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class formDetail extends StatefulWidget {
  @override
  _formDetailState createState() => _formDetailState();
}

class _formDetailState extends State<formDetail> {
  String user, search;
  Timer debouncer;
  TextEditingController searc = TextEditingController();

  List<Post> post = List();
  List<int> totalInts = List();
  List<List<String>> listType = List();
  List<List<String>> listCost = List();
  List<List<String>> listUnit = List();
  List<List<String>> listSum = List();

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

  /*Future init() async {
    final post = await Network.getPost(search);

    setState(() => this.post = post);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('รายการวันนี้'),
      ),
      body: Column(
        children: <Widget>[
          //buildSearch(),
          Expanded(
              child: ListView.builder(
                  itemCount: post.length,
                  itemBuilder: (context, index) {
                    final postes = post[index];
                    return buildlist(postes);
                  }))
        ],
      ),
    );
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = preferences.getString('state');
    readAllOrder();
  }

  Future<Null> readAllOrder() async {
    if (user != null) {
      DateTime dateTime = DateTime.now();
      String date = DateFormat('dd-MM-yyyy').format(dateTime);

      String url =
          '${MyUrl().domain}/chanthip/whereDate.php?isAdd=true&date=${date}';

      Response response = await Dio().get(url);
      //print('data = $response');
      if (response.toString() != 'null') {
        var result = json.decode(response.data);
        for (var map in result) {
          Post model = Post.fromJson(map);

          setState(() {
            post.add(model);
          });
        }
      }
    }
  }

  /*Widget buildSearch() => Container(
        width: 300,
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: TextField(
          controller: searc,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'วัน-เดือน-ปี // ชื่องาน',
            labelText: 'ค้นหา ...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onChanged: searchPost,
        ),
      );*/

  Widget buildlist(Post postes) => Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          leading: Icon(Icons.arrow_forward_ios),
          title: Text(postes.date),
          subtitle: Text(postes.work),
          tileColor: Colors.blue[100],
          trailing: Icon(
            Icons.star,
            color: Colors.orange,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => test12(postes)));
          },
        ),
      );

  Future searchPost(String search) async => debounce(() async {
        final post = await Network.getPost(search);

        if (!mounted) return;

        setState(() {
          this.search = search;
          this.post = post;
        });
      });
}
