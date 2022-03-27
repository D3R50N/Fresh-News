import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:flutter_app/helpers/newshelper.dart';
import 'package:flutter_app/views/news_view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

int currentPage = 0;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NewsHelper vHelper = NewsHelper();
  List<NewsItem> allNewsItems = [];
  bool isLoaded = false;
  bool failed = false;
  bool logoShow = false;
  Color appbarcol = maincol;

  @override
  void initState() {
    super.initState();
    refresh(0);
  }

  void refresh(int pageIdx) {
    currentPage = pageIdx;
    setState(() {
      failed = false;
      logoShow = true;
      isLoaded = false;
    });
    vHelper
        .getNews(http.read(Uri.parse(
      "https://afrique.tv5monde.com/information/dossier/lactualite-au-benin?xtor=SEC-9-GOO-[AF_SE_Info_Pays]-[72851151547]-S-[b%C3%A9nin%20news]&gclid=Cj0KCQjw5-WRBhCKARIsAAId9FkdIw1cmp7SvzTIZlDwwGP9JjSuLj7CEuND71yw2HutkvE4NjPVy0waAsqXEALw_wcB/%3Fpage%3D3&page=" +
          pageIdx.toString(),
    )))
        .then((value) {
      if (value.isEmpty) {
        setState(() {
          failed = true;
          logoShow = false;
        });
      } else {
        setState(() {
          isLoaded = true;
          allNewsItems = value;
          logoShow = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: maincol,
        appBar: homeAppBar(context),
        body: NewsPageView(
          refresh: refresh,
          isLoaded: isLoaded,
          failed: failed,
          allNewsItems: allNewsItems,
        ),
      ),
    );
  }

  AppBar homeAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: appbarcol,
      leading: IconButton(
        onPressed: () {
          ZoomDrawer.of(context)!.toggle();
        },
        icon: Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
          ),
          iconSize: 20,
          splashRadius: 20,
          highlightColor: themecol,
        ),
        Gap(10),
      ],
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            " Fresh ",
            style: GoogleFonts.nunito(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // if (logoShow)
          Icon(
            Icons.all_inclusive,
            size: 30,
            color: themecol,
          ),
          Text(
            " News ",
            style: GoogleFonts.nunito(
              fontSize: 25,
              color: themecol,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
