import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends StatefulWidget {
  NewsPage({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
  }) : super(key: key);
  final int id;
  final String title;
  final String content;
  String imageUrl;
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool imgLoading = true;
  String siteUrl = "https://afrique.tv5monde.com/";
  String defaultImgUrl =
      "https://as2.ftcdn.net/v2/jpg/01/67/74/79/1000_F_167747932_NE1da5cf9FM30QExtlFjbmk9ypItoJl2.jpg";
  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardcol,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  height: .9,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Image.network(
                  (widget.imageUrl != "")
                      ? siteUrl + widget.imageUrl
                      : defaultImgUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    int l = loadingProgress?.cumulativeBytesLoaded ?? 0;
                    int ex = loadingProgress?.expectedTotalBytes ?? 1;
                    if (loadingProgress == null) return child;

                    return CircularProgressIndicator(
                      value: l / ex.toDouble(),
                      color: themecol,
                      backgroundColor: maincol,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      "Impossible de charger l'image",
                      style: TextStyle(
                        color: themecol,
                      ),
                    );
                  },
                ),
              ),
              Text(
                widget.content,
                textAlign: TextAlign.justify,
                style: GoogleFonts.nunito(),
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
