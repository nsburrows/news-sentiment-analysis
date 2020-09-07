import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/news.dart';
import '../view/web_view.dart';
import '../model/new_categories.dart';
import '../model/color_pallete.dart';

class NewsListView extends StatefulWidget {
  final int catId;

  NewsListView(this.catId);

  @override
  State<StatefulWidget> createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsListView> {
  List<SentimentArticle> list;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<List<SentimentArticle>> getData() async {
    String link;
    print(widget.catId);
    // Get data from my API that has the sentiment analysis score
    link = "https://world101.herokuapp.com/apiv2/newsarticles/" +
        NewsCategories.getNewsCategory(widget.catId).toLowerCase();
    print(NewsCategories.getNewsCategory(3).toLowerCase());

    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    setState(() {
      if (res.statusCode == 200) {
        list = (json.decode(res.body) as List)
            .map<SentimentArticle>((json) => SentimentArticle.fromJson(json))
            .toList();
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CssColor().defaultBarBackground,
          title: Text(NewsCategories.getNewsCategory(widget.catId)),
        ),
        backgroundColor: CssColor().defaultBackground,
        body: list != null
            ? Container(
                child: RefreshIndicator(
                onRefresh: getData,
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (ctxt, i) {
                      double score =
                          double.parse(list[i].sentimentScore) * 100 ?? 0;
                      String iurl = list[i].imageUrl;
                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                width: 6,
                                color: score > 0
                                    ? Colors.lightGreenAccent
                                    : score < 0
                                        ? Colors.red
                                        : Colors.transparent)),
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            image: DecorationImage(
                              image: iurl != null
                                  ? NetworkImage(iurl)
                                  : AssetImage('images/no_image_available.png'),
                              colorFilter: ColorFilter.mode(
                                  Colors.black54.withOpacity(0.5),
                                  BlendMode.hardLight),
                              fit: BoxFit.fill,
                            ),
                          ),
                          height: 120,
                          child: Center(
                            child: ListTile(
                              title: Text('${list[i].title}', style: TextStyle(fontFamily: 'Raleway'),),
                              subtitle: getGrade(score),
                              onTap: () => _onTapItem(context, list[i]),
                            ),
                          ),
                        ),
                      );
                    }),
              ))
            : Center(child: CircularProgressIndicator()));
  }

  /**
   * Will returns the grade based on a sentiment score
   */
  Text getGrade(double score) {
    String grade = 'F';

    if (score >= 70)
      grade = 'A';
    else if (score >= 20)
      grade = 'B';
    else if (score >= -20)
      grade = 'C';
    else if (score >= -70)
      grade = 'D';
    else
      grade = 'F';

    return Text(grade,
        style: TextStyle(color: Colors.amber, fontSize: 24), textAlign: TextAlign.right,);
  }
}

void _onTapItem(BuildContext context, SentimentArticle article) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) =>
          WebView(article.url, article.newsSourceName)));
}
