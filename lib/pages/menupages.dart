import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:flutter_app/pages/gotopro.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/pagesnotfound.dart';
import 'package:flutter_app/screens/menu_screen.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      backgroundColor: themecol,
      menuScreen: Menu(),
      mainScreen: Home(),
    );
  }
}

class GotoProPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      backgroundColor: themecol,
      menuScreen: Menu(),
      mainScreen: GotoPro(),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      backgroundColor: themecol,
      menuScreen: Menu(),
      mainScreen: PageNotFound(),
    );
  }
}
