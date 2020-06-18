import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyImagesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmptyImagesList();
}

class _EmptyImagesList extends State<EmptyImagesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 240),
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text("Mischief Managed!",
              style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text("You're all cleaned up!",
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
