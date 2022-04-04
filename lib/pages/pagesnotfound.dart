import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  State<PageNotFound> createState() => _PageNotFoundState();
}

class _PageNotFoundState extends State<PageNotFound> {
  String dot = "";
  bool isstarted = false;
  @override
  Widget build(BuildContext context) {
    if (!isstarted) {
      Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          setState(() {
            dot += ".";
            if (dot.length > 3) dot = "";
          });
        },
      );
      setState(() {
        isstarted = true;
      });
    }
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: maincol,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/wrench_96px.png"),
            Text(
              "Page en constrction" + dot,
              style: GoogleFonts.nunito(color: cardcol),
            ),
          ],
        ),
      ),
    );
  }
}
