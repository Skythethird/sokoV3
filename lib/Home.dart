import 'package:flutter/material.dart';
import 'package:sokoV3/barcode_generate.dart';
import 'package:sokoV3/database_helper.dart';
import 'detail.dart';
import 'AnimatedSearchBar.dart';
import 'Widget/list_item_widget.dart';
import 'data/list_items.dart';
import 'package:sokoV3/model/list_item.dart';
import 'add_new_product.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'filter_test.dart';
import 'list_test.dart';
import 'database_helper.dart';

// import 'model/list_item.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> allProducts;

  Future<bool> getProduct() async {
    allProducts = await dbHelper.queryAllRows();
    print(allProducts);
    return true;
  }

  Future<int> deleteProduct(int id) async {
    var numberOfDelete = await dbHelper.delete(id);
    print('Delete Product ID: $id');
    return numberOfDelete;
  }

  final List<ListItem> items = List.from(listItems);
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
      // body: SingleChildScrollView(
      //         child: Column(
      //     children: [
      //       AnimatedSearchBar(),
      //       // ListItemWidget(item:listItems[0]),
      //       SizedBox(
      //         height: 400,
      //         child: AnimatedList(
      //           initialItemCount: items.length,
      //           itemBuilder: (context, index, animation) => ListItemWidget(
      //             item: items[index],
      //             animation:  animation,
      //             onClicked: () {},
      //           )),
      //       )
            
      //     ],
      //   ),

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       AnimatedSearchBar(),
      //       // ListItemWidget(item:listItems[0]),
      //       // SizedBox(
      //       //         height: 400,
      //       //         child: AnimatedList(
      //       //             initialItemCount: items.length,
      //       //             itemBuilder: (context, index, animation) =>
      //       //                 ListItemWidget(
      //       //                   item: items[index],
      //       //                   animation: animation,
      //       //                   onClicked: () {},
      //       //                 )),
      //       //       );
      //     ],
      //   ),
      // ),
      body: FutureBuilder(
        future: getProduct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (BuildContext context, int index) {
                var myProduct = allProducts[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction){
                    setState(() {
                      List.from(allProducts).removeAt(index);
                      deleteProduct(myProduct['id']);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product Deleted'))
                    );
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text(myProduct['productname']),
                      subtitle: Text(myProduct['amount'].toString()),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                );
                    
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         _showPicker(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.qr_code_2),
      ),
      // body: SingleChildScrollView(
      //         child: Column(
      //     children: [
      //       Column(children: [AnimatedSearchBar()]),
      //       ListItemWidget(item:listItems[0]),
      //     ],
      //   ),
      // ),
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
              context, MaterialPageRoute(builder: (context) => AddNewProductPage()));
        },
        child: Icon(
            Icons.add
        ),
      )
      )
    ],
    // backgroundColor: Color(0xff3D3D3D),
    backgroundColor: Color.fromRGBO(60, 56, 67, 1.0),
  );
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
                      context, MaterialPageRoute(builder: (context) => BarcodeGen()));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
