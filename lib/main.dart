import 'package:flutter/material.dart';
import './view/homepage.dart';
import './model/color_pallete.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Sentiment Analysis',
      theme: new ThemeData(
          primarySwatch: Colors.amber,
          accentColor: CssColor().spicedButternut,
          fontFamily: 'Bebes',
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      home: NewsListPage('News Sentiment Analysis'),
    );
  }
}

class NewsListPage extends StatefulWidget {
  final String title;

  NewsListPage(this.title);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: CssColor().defaultBarBackground,
          leading: Image(
            image: AssetImage('images/app_logo.png'),
            height: 0,
          ),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(child: Text('Placeholder'))
                ];
              },
            )
          ],
        ),
        body: PageSelectorDemo() //NewsListView('Top')
        );
  }
}
