import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:flutter_app/helpers/newshelper.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/news_page.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPageView extends StatefulWidget {
  const NewsPageView({
    Key? key,
    required this.isLoaded,
    required this.refresh,
    required this.failed,
    required this.allNewsItems,
  }) : super(key: key);

  final bool isLoaded;
  final bool failed;
  final Function(int pageIdx) refresh;

  final List<NewsItem> allNewsItems;

  @override
  State<NewsPageView> createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView> {
  List<String> menuDrop = [
    "Les plus récentes",
    "Les plus populaires",
    "Les plus anciennes",
  ];
  int currentMenu = 0;
  String logoBJ =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Benin.svg/langfr-1280px-Flag_of_Benin.svg.png";
  double w = 50;
  bool isVisible = false;

  String query = "";
  List<NewsItem> resultItems = [];
  bool resultFound = true;
  @override
  void initState() {
    super.initState();
    resultItems.addAll(widget.allNewsItems);
  }

  void searchNews(String q) {
    setState(() {
      resultItems.clear();
    });
    if (q.trim() == "") return;

    setState(() {
      query = q.toLowerCase();
      resultFound = false;
    });

    widget.allNewsItems.forEach((element) {
      if (element.title.toLowerCase().contains(query) ||
          element.content.toLowerCase().contains(query))
        setState(() {
          resultItems.add(element);
          resultFound = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchBarContainer(context, searchNews),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
          child: Row(
            children: [
              Spacer(),
              Visibility(
                visible: isVisible,
                child: filterContainer(),
              ),
              Gap(20),
            ],
          ),
        ),
        Expanded(
          child: (!widget.isLoaded && !widget.failed)
              ? Center(child: CircularProgressIndicator(color: themecol))
              : (widget.isLoaded && !widget.failed)
                  ? resultFound
                      ? allNewsCards()
                      : notFound()
                  : errorWidget(),
        ),
      ],
    );
  }

  Widget notFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            color: Colors.grey.withOpacity(.3),
            size: 45,
          ),
          Text(
            "Aucune actualité trouvée",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.withOpacity(.3),
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBarContainer(BuildContext context, Function(String q) search) {
    String searchQuery = "";
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AnimatedContainer(
            width: w,
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(.7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onChanged: (v) {
                setState(() {
                  searchQuery = v;
                });
                search(v);
              },
              onTap: () {
                setState(() {
                  w = MediaQuery.of(context).size.width - 50;
                  isVisible = true;
                });
              },
              onEditingComplete: () {
                setState(() {
                  FocusScope.of(context).unfocus();
                  w = 50;
                  isVisible = false;
                  search(searchQuery);
                });
              },
              onSubmitted: (v) {
                setState(() {
                  FocusScope.of(context).unfocus();
                  w = 50;
                  isVisible = false;
                  search(v);
                });
              },
              cursorColor: themecol,
              style: GoogleFonts.nunito(color: cardcol),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: themecol),
                fillColor: Colors.white.withOpacity(.03),
                filled: true,
                labelText: "Rechercher",
                labelStyle: TextStyle(color: cardcol),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Spacer(),
              Visibility(
                visible: !isVisible,
                child: filterContainer(),
              ),
              Gap(20),
            ],
          ),
        ),
      ],
    );
  }

  Widget allNewsCards() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: resultItems.length == 0
            ? widget.allNewsItems.length
            : resultItems.length,
        itemBuilder: (context, index) {
          List<NewsItem> list =
              resultItems.length == 0 ? widget.allNewsItems : resultItems;
          String title = list[index].title;
          String content = list[index].content;
          String date = list[index].date;
          String? url = list[index].imageUrl;
          return Hero(
            tag: "new_page " + index.toString(),
            child: singleNewsCard(context, index, title, content, url, date),
          );
        },
      ),
    );
  }

  Widget errorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mobiledata_off,
            color: Colors.grey.withOpacity(.3),
            size: 25,
          ),
          Text(
            "Erreur de connexion",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.withOpacity(.3),
              fontSize: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
                onPressed: () {
                  searchNews("");
                  widget.refresh(currentPage);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  backgroundColor: MaterialStateProperty.all(themecol),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.restart_alt_rounded,
                      size: 25,
                    ),
                    Text(
                      "Réessayer",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget singleNewsCard(BuildContext context, int index, String title,
      String content, String? url, String date) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              color: themecol,
              margin: EdgeInsets.symmetric(
                vertical: 0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showAnimatedDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    insetPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                    backgroundColor: Colors.transparent,
                    content: NewsPage(
                      id: index,
                      title: title,
                      content: content,
                      imageUrl: url ?? "",
                    ),
                  );
                },
                animationType: DialogTransitionType.scale,
                curve: Curves.bounceIn,
                duration: Duration(seconds: 1),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: cardcol,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Center(
                    child: Text(
                      title,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      content,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.nunito(),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterContainer() {
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: currentMenu,
          borderRadius: BorderRadius.circular(10),
          icon: Icon(
            Icons.filter_list_rounded,
            color: themecol,
          ),
          alignment: Alignment.center,
          onChanged: (value) {
            if (currentMenu == value) return;
            searchNews("");

            setState(() {
              currentMenu = int.parse(value.toString());
            });
            if (currentMenu == 0)
              widget.refresh(0);
            else if (currentMenu == 1)
              widget.refresh(Random().nextInt(7));
            else if (currentMenu == 2) widget.refresh(6);
          },
          dropdownColor: maincol,
          items: menuDrop.map((e) {
            return DropdownMenuItem(
              child: Text(
                e,
                style: GoogleFonts.nunito(
                  color: themecol,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: menuDrop.indexOf(e),
            );
          }).toList(),
        ),
      ),
    );
  }
}
