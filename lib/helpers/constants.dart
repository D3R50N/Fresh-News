import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

const Color maincol = Color.fromRGBO(40, 42, 58, 1);
const Color themecol = Color.fromRGBO(255, 70, 90, 1);
const Color cardcol = Color.fromRGBO(244, 247, 250, 1);

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.customAction,
    Key? key,
  }) : super(key: key);

  final Widget? customAction;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: maincol,
      leading: IconButton(
        onPressed: () {
          ZoomDrawer.of(context)!.toggle();
        },
        icon: Icon(Icons.menu),
      ),
      actions: [widget.customAction ?? Gap(20)],
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
