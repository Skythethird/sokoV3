import 'package:flutter/material.dart';
import 'detail.dart';
import 'AnimatedSearchBar.dart';
import 'Widget/list_item_widget.dart';
import 'data/list_items.dart';
import 'package:sokoV3/model/list_item.dart';
import 'add_new_product.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'filter_test.dart';
import 'list_test.dart';
// import 'model/list_item.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ListItem> items = List.from(listItems);
  String _counter,_value = "";
  String query = '';
  Future _barcode() async{

    _counter = await FlutterBarcodeScanner.scanBarcode("#004397", "Cancel", true, ScanMode.DEFAULT);

    setState(() {
      _value= _counter;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),

      body: SingleChildScrollView(
              child: Column(
          children: [
            AnimatedSearchBar(),
            // ListItemWidget(item:listItems[0]),
            SizedBox(
              height: 400,
              child: AnimatedList(
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) => ListItemWidget(
                  item: items[index],
                  animation:  animation,
                  onClicked: () {},
                )),
            )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _barcode,
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
    backgroundColor: Color(0xff3D3D3D),
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
//     final books = allBooks.where((book) {
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
}