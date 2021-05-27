

import 'package:flutter/material.dart';

import 'data/list_items.dart';
import 'detail_item.dart';
import 'filter_test.dart';
import 'model/list_item.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  List<ListItem> items;
  String query = '';

  @override
  void initState() {
    super.initState();

    items = listItems;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('test'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return buildBook(item);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Widget buildBook(ListItem item) => ListTile(
        leading: Image.network(
          item.urlImage,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(item.title),
        tileColor: Colors.blue,
        onTap:(){print('load');
      Navigator.push(
      context, MaterialPageRoute(builder: (context) => DetailItem(item.title)));},
      );

  void searchBook(String query) {
    final items = listItems.where((item) {
      final titleLower = item.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ;
    }).toList();

    setState(() {
      this.query = query;
      this.items = items;
    });
  }
}