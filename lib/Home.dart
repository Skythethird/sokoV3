import 'package:flutter/material.dart';
import 'package:sokoV3/barcode_generate.dart';
import 'package:sokoV3/database_helper.dart';
import 'detail.dart';
import 'Widget/new_list_item_widget.dart';
import 'data/list_items.dart';
import 'package:sokoV3/model/list_item.dart';
import 'add_new_product.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'filter_test.dart';
import 'database_helper.dart';
import 'detail_item.dart';
import 'filter_test.dart';

// import 'model/list_item.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> allProducts;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _list;
  final List<Map<String, dynamic>> _listProduct1=[];

  Future<bool> getAllProduct() async {
    allProducts = await dbHelper.queryAllRows();
    _listProduct1.addAll(allProducts);
    // setState(() {
    //   _listProduct1.addAll(allProducts);
    // });
    
    return true;
  }

  Future<int> deleteProduct(int id) async {
    var numberOfDelete = await dbHelper.delete(id);
    print('Delete Product ID: $id');
    return numberOfDelete;
  }

  final List<ListItem> items1 = List.from(listItems);
  final List<ListItem> items2 = List.from(listItems);
  final removedItems = [];
  List<ListItem> _items = List.from(listItems);
  String _counter, _value = "";
  String query = '';
  Future _barcode() async {
    _counter = await FlutterBarcodeScanner.scanBarcode(
        "#004397", "Cancel", true, ScanMode.DEFAULT);

    setState(() {
      _value = _counter;
    });
  }

  @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color.fromRGBO(255, 252, 231, 1.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearch(),
            FutureBuilder(
                future: getAllProduct(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 660,
                      child: AnimatedList(
                          key: _listKey,
                          initialItemCount: _listProduct1.length,
                          itemBuilder: (context, index, animation) =>
                              ListItemWidget(
                                item: _listProduct1[index],
                                animation: animation,
                                onClicked: (){},
                              )),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {_showPicker(context);},
        child: Icon(Icons.qr_code_2),
        backgroundColor: Color.fromRGBO(191, 181, 140, 1.0),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text('List Product'),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewProductPage())).then((_) {initState();});
              },
              child: Icon(Icons.add,size: 32,),
            ))
      ],
      // backgroundColor: Color(0xff3D3D3D),
      backgroundColor: Color.fromRGBO(60, 56, 67, 1.0),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchProducts,
      );

  void searchProducts(String query) {
    List<Map<String, dynamic>> deleteList = [];
    String textLowercase = query.toLowerCase();
    allProducts.asMap().forEach((index, element) {
      String foodLowercase = element['productname'].toLowerCase();
      if (!foodLowercase.contains(textLowercase)) {
        deleteList.add(element);
      } else if (foodLowercase.contains(textLowercase) &&
        _listProduct1.indexWhere((e) => e['id'] == element['id']) == -1) {
        insertItem(_listProduct1.length, element);
      }
    });

    deleteList.forEach((element) {
      int deleteIndex = _listProduct1.indexWhere((e) => e['id'] == element['id']);
      print('deleteIndex: '+deleteIndex.toString());
      print(element);
      if (_listProduct1.indexWhere((e) => e['id'] == element['id']) != -1) {
        removeItem(deleteIndex);
      }
    });
  }

  void insertItem(int index, item) {
    if (removedItems.length != 0) {
      _listProduct1.insert(index, removedItems.first);
      removedItems.removeAt(0);
      _listProduct1.sort((a, b) => a['productname'].compareTo(b['productname']));
      _listKey.currentState.insertItem(index);
    }
  }

  void removeItem(int index) {
    removedItems.add(_listProduct1[index]);
    final item = _listProduct1.removeAt(index);
    _listProduct1.sort((a, b) => a['productname'].compareTo(b['productname']));
    _listKey.currentState.removeItem(
      index,
      (context, animation) => ListItemWidget(item: item, animation: animation),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.qr_code_scanner),
                      title: new Text('Scanner'),
                      onTap: () {
                        _barcode();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.qr_code_sharp),
                    title: new Text('Save Barcode'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarcodeGen()));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
