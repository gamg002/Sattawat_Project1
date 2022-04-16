import 'package:flutter/material.dart';
import 'package:helo/widget/home.dart';

Future<void> normal1(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                color: Colors.green,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homescreen())),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              width: 20,
            ),
            FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )
      ],
    ),
  );
}
