import 'package:flutter/material.dart';
import './news_list_view.dart';
import '../model/new_categories.dart';
import '../model/color_pallete.dart';

class _PageSelector extends StatelessWidget {
  const _PageSelector({this.icons});

  final List<Icon> icons;

  void _handleArrowButtonPress(BuildContext context, int delta) {
    final TabController controller = DefaultTabController.of(context);
    if (!controller.indexIsChanging)
      controller
          .animateTo((controller.index + delta).clamp(0, icons.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final TabController controller = DefaultTabController.of(context);
    final Color color = Theme.of(context).accentColor;
    int i = -1;
    return SafeArea(
      top: false,
      bottom: false,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: color,
                  onPressed: () {
                    _handleArrowButtonPress(context, -1);
                  },
                  tooltip: 'Page back',
                ),
                TabPageSelector(controller: controller),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: color,
                  onPressed: () {
                    _handleArrowButtonPress(context, 1);
                  },
                  tooltip: 'Page forward',
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Expanded(
            child: IconTheme(
              data: IconThemeData(
                size: 128.0,
                color: color,
              ),
              child: TabBarView(
                children: icons.map<Widget>((Icon icon) {
                  i++;
                  return Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: CssColor().swanWhiteTransperant,
                        child: ListTile(
                          onTap: () => _onTapItem(context, icon),
                          title: Center(
                              child: Column(children: <Widget>[
                            icon,
                            Text(NewsCategories.getNewsCategory(i),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 50))
                          ])),
                        ),
                      ));
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapItem(BuildContext context, Icon i) {
    int counter = 0;
    switch (i) {
      case Icon(Icons.business, semanticLabel: 'Business', size: 250.0):
        counter = 0;
        break;
      case Icon(Icons.movie, semanticLabel: 'Entertainment', size: 250.0):
        counter = 1;
        break;
      case Icon(Icons.language, semanticLabel: 'General', size: 250.0):
        counter = 2;
        break;
      case Icon(Icons.local_hospital, semanticLabel: 'Health', size: 250.0):
        counter = 3;
        break;
      case Icon(Icons.lightbulb_outline, semanticLabel: 'Science', size: 250.0):
        counter = 4;
        break;
      case Icon(Icons.directions_run, semanticLabel: 'Sports', size: 250.0):
        counter = 5;
        break;
      case Icon(Icons.computer, semanticLabel: 'Technology', size: 250.0):
        counter = 6;
        break;
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewsListView(counter)));
  }
}

class PageSelectorDemo extends StatelessWidget {
  static final List<Icon> icons = <Icon>[
    const Icon(
      Icons.business,
      semanticLabel: 'Business',
      size: 250.0,
    ),
    const Icon(Icons.movie, semanticLabel: 'Entertainment', size: 250.0),
    const Icon(Icons.language, semanticLabel: 'General', size: 250.0),
    const Icon(Icons.local_hospital, semanticLabel: 'Health', size: 250.0),
    const Icon(Icons.lightbulb_outline, semanticLabel: 'Science', size: 250.0),
    const Icon(Icons.directions_run, semanticLabel: 'Sports', size: 250.0),
    const Icon(Icons.computer, semanticLabel: 'Technology', size: 250.0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CssColor().defaultBackground,
      body: DefaultTabController(
        length: icons.length,
        child: _PageSelector(icons: icons),
      ),
    );
  }
}
