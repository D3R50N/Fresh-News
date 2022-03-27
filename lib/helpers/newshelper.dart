import 'package:flutter/foundation.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class NewsItem {
  NewsItem({
    required this.title,
    required this.content,
    required this.date,
    this.imageUrl,
  });

  final String title;
  final String content;
  final String date;
  String? imageUrl;
}

class NewsHelper {
  static List<NewsItem> foundedNews = [];
  Future<List<NewsItem>> getNews(request) async {
    foundedNews.clear();
    List<NewsItem> mylist = [];
    var response;
    try {
      response = await request;
    } catch (e) {
      debugPrint("Erreur ");
      print(e);
      return [];
    }
    dom.Document doc = parse(response);

    List videoTitle = doc.querySelectorAll(".views-row");
    if (videoTitle.isEmpty) {
      print("vide");
    }
    for (var element in videoTitle) {
      if (element.querySelector(".item-content") == null) continue;
      if (element.querySelector(".field__item>picture>img") == null) continue;

      dom.Element img = element.querySelector(".field__item>picture>img");
      dom.Element title = element
          .querySelector(".views-field-title")
          .querySelector(".field-content");
      dom.Element content = element
          .querySelector(".views-field-body")
          .querySelector(".field-content");
      dom.Element createdDate = element
          .querySelector(".views-field-created")
          .querySelector(".field-content");

      String titletext;
      titletext = title.text;
      String contenttext;
      contenttext = content.text;
      String datetext = createdDate.text;

      mylist.add(
        NewsItem(
          content: contenttext,
          title: titletext,
          date: datetext,
          imageUrl: img.attributes["src"],
        ),
      );
    }
    foundedNews.addAll(mylist);
    return mylist;
  }
}
