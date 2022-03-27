import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem {
  final String title;
  final IconData icondata;

  const MenuItem({required this.title, required this.icondata});
}

class MenuItems {
  static List<MenuItem> all = [
    MenuItem(title: "Acceuil", icondata: Icons.home_rounded),
    MenuItem(title: "Découvrir", icondata: Icons.fiber_new),
    MenuItem(title: "Passer à PRO", icondata: Icons.monetization_on_rounded),
  ];

  static List<MenuItem> allBottom = [
    MenuItem(title: "Paramètres", icondata: Icons.settings_rounded),
    MenuItem(title: "Signaler un problème", icondata: Icons.report_rounded),
    MenuItem(title: "Partager", icondata: Icons.share_rounded),
  ];
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: themecol,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    ZoomDrawer.of(context)!.toggle();
                  },
                ),
              ),
              ...MenuItems.all.map((e) {
                return ListTile(
                  horizontalTitleGap: 0,
                  title: Text(
                    e.title,
                    style: GoogleFonts.nunito(),
                  ),
                  leading: Icon(
                    e.icondata,
                  ),
                  onTap: () {},
                );
              }).toList(),
              Gap(30),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Divider(
                  thickness: 1,
                  color: Colors.white.withOpacity(.4),
                ),
              ),
              ...MenuItems.allBottom.map((e) {
                return ListTile(
                  horizontalTitleGap: 0,
                  title: Text(
                    e.title,
                    style: GoogleFonts.nunito(),
                  ),
                  leading: Icon(
                    e.icondata,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Home();
                        },
                      ),
                    );
                  },
                );
              }).toList(),
              Expanded(
                flex: 2,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    ZoomDrawer.of(context)!.toggle();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}