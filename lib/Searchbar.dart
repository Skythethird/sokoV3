
import 'package:flutter/material.dart';

class Search_Bar extends StatefulWidget {
  @override
  _Search_BarState createState() => _Search_BarState();
}

class _Search_BarState extends State<Search_Bar> {
  static const historyLength = 5;
  List<String> _searchHistory =[
    "1",
    "2",
    "3",
    "4",
  ];
  List<String> filteredSearchHistory;

  String selectedTerm;

  List<String> filterSearchTerms({
    @required String filter,
  }){
      if (filter != null && filter.isNotEmpty){
        return _searchHistory.reversed
        .where((term) => term.startsWith(filter))
        .toList();
      }else{
        return _searchHistory.reversed.toList();
        
      }
  }

  void addSearchTerm(String term){
    if(_searchHistory.contains(term)){
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if(_searchHistory.length > historyLength){
      _searchHistory.removeRange(0, _searchHistory.length - historyLength)
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchResultsListView(
        searchTerm: null,
      ),
    );
  }
}
class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key key,
    @required this.searchTerm,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
   if (searchTerm = null){
      return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          Icon(Icons.search,size:64),
          Text('Start search',style:Theme.of(context).textTheme.headline5,)
        ]
      ),
    );
   }
  }
}