import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_app/pages/homepage.dart';

class spleshScreanflutter extends StatefulWidget {
  const spleshScreanflutter({Key? key}) : super(key: key);

  @override
  _spleshScreanflutterState createState() => _spleshScreanflutterState();
}

class _spleshScreanflutterState extends State<spleshScreanflutter> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Center(
          child: Icon(Icons.airplanemode_active_rounded,color: Colors.white,size: 100,)
        //     child: Image.asset(
        //   'images/logo.png',
        //   height: 300,
        //   width: 300,
        //   fit: BoxFit.fill,
        // )
        ));
  }
}
