import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/menupages.dart';
import 'package:flutter_app/screens/menu_screen.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
