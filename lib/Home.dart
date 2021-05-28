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

  Future<bool> getProduct() async {
    allProducts = await dbHelper.queryAllRows();
    _listProduct1.addAll(allProducts);
    print(allProducts);
    print(_listProduct1);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color.fromRGBO(255, 252, 231, 1.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearch(),
            FutureBuilder(
                future: getProduct(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 400,
                      child: AnimatedList(
                          key: _listKey,
                          initialItemCount: _listProduct1.length,
                          itemBuilder: (context, index, animation) =>
                              ListItemWidget(
                                item: _listProduct1[index],
                                animation: animation,
                                onClicked: () {},
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

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       buildSearch(),
      //       // AnimatedSearchBar(),
      //       // ListItemWidget(item:listItems[0]),
      //       SizedBox(
      //         height: 400,
      //         child: AnimatedList(
      //           key: _listKey,
      //           initialItemCount: items1.length,
      //           itemBuilder: (context, index, animation) =>
      //           // Text(_items.length.toString())
      //           ListItemWidget(
      //             item: items1[index],
      //             animation:  animation,
      //             onClicked: () {},
      //           )
      //           ),
      //       )

      //     ],
      //   ),
      // ),

      // body: Column(
      //   children: [
      //     buildSearch(),
      //     FutureBuilder(
      //       future: getProduct(),
      //       builder: (BuildContext context, AsyncSnapshot snapshot) {
      //         if(_list == null){_list = allProducts;}
      //         if (snapshot.hasData) {
      //           return Expanded(
      //             child:ListView.separated(
      //             padding: const EdgeInsets.all(8),
      //             itemCount: _list.length,
      //             itemBuilder: (BuildContext context, int index) {
      //               var myProduct = _list[index];
      //               return Dismissible(
      //                 key: UniqueKey(),
      //                 onDismissed: (direction){
      //                   setState(() {
      //                     List.from(allProducts).removeAt(index);
      //                     deleteProduct(myProduct['id']);
      //                   });
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     SnackBar(content: Text('Product Deleted'))
      //                   );
      //                 },
      //                 background: Container(color: Colors.red),
      //                 child: ListTile(
      //                     leading: Icon(Icons.image),
      //                     title: Text(myProduct['productname']),
      //                     subtitle: Text(myProduct['amount'].toString()),
      //                     trailing: Icon(Icons.keyboard_arrow_right),
      //                     ),
      //               );

      //             },
      //             separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,color: Colors.black,),
      //           ));
      //         } else {
      //           return Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         }
      //       },
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _barcode,
        child: Icon(Icons.qr_code_2),
        backgroundColor: Color.fromRGBO(191, 181, 140, 1.0),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text('List product'),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewProductPage()));
              },
              child: Icon(Icons.add),
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

// void searchBook(String query) {
//     final items = listItems.where((item) {
//       final titleLower = item.title.toLowerCase();
//       final searchLower = query.toLowerCase();
//       return titleLower.contains(searchLower) ;
//     }).toList();

//     setState(() {
//       this.query = query;
//       _items = items;
//     });
//   }

  void searchBook2(String query) {
    final items = allProducts.where((myProduct) {
      final titleLower = myProduct['productname'].toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      _list = items;
    });
  }

// Widget getBody() {
//   bool _folded = true;
//   return AnimatedContainer(
//       duration: Duration(milliseconds: 400),
//       width: _folded ? 56 : 200,
//       height: 56,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(32),
//         color: Colors.white,
//         boxShadow: kElevationToShadow[6],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 16),
//               child: !_folded
//                   ? TextField(
//                       decoration: InputDecoration(
//                           hintText: 'Search',
//                           hintStyle: TextStyle(color: Colors.blue[300]),
//                           border: InputBorder.none),
//                     )
//                   : null,
//             ),
//           ),
//           AnimatedContainer(
//               duration: Duration(milliseconds: 400),
//               child: Material(
//                 type: MaterialType.transparency,
//                 child: InkWell(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(_folded ? 32 : 0),
//                       topRight: Radius.circular(32),
//                       bottomLeft: Radius.circular(_folded ? 32 : 0),
//                       bottomRight: Radius.circular(32),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Icon(
//                         _folded ? Icons.search : Icons.close,
//                         color: Colors.blue[900],
//                       ),
//                     ),

//                     onTap: () {
//                       setState(() {
//                         print("yayyyy");
//                         _folded = !_folded;
//                       });
//                     }),
//               ),
//               )
//         ],
//       ));
// }

// Widget buildSearch() => SearchWidget(
//         text: query,
//         hintText: 'Title or Author Name',
//         onChanged: searchBook,
//       );
// void searchBook(String query) {
//     final books = allProducts.where((book) {
//       final titleLower = book.title.toLowerCase();
//       final authorLower = book.author.toLowerCase();
//       final searchLower = query.toLowerCase();

//       return titleLower.contains(searchLower) ||
//           authorLower.contains(searchLower);
//     }).toList();

//     setState(() {
//       this.query = query;
//       // this.books = books;
//     });
//   }
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
                      title: new Text('Photo Library'),
                      onTap: () {
                        _barcode();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.qr_code_sharp),
                    title: new Text('Camera'),
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
