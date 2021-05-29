import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokoV3/add_image.dart';
import 'database_helper.dart';

class EditProductPage extends StatefulWidget {
  final id;
  const EditProductPage(this.id);

  @override
  _EditProductPage createState() => _EditProductPage();
}

class _EditProductPage extends State<EditProductPage> {
  String _nameProduct;
  String _detail;
  int _amount;
  int _retailPrice;
  int _wholesalePrice;
  String _category;

  final dbHelper = DatabaseHelper.instance;

  Map<String, dynamic> productData;

  Future<Map<String, dynamic>> getProduct(int id) async {
    productData = await dbHelper.getProductData(id);
    _nameProduct = productData['productname'];
    _detail = productData['detail'];
    _amount = productData['amount'];
    _retailPrice = productData['retail'];
    _wholesalePrice = productData['wholesale'];
    _category = productData['category'];
    return productData;
  }

  void updateProduct() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnProductname: _nameProduct,
      DatabaseHelper.columnDetail: _detail,
      DatabaseHelper.columnAmount: _amount,
      DatabaseHelper.columnRetail: _retailPrice,
      DatabaseHelper.columnWholesale: _wholesalePrice,
      DatabaseHelper.columnCategory: _category
    };
    final id = await dbHelper.update(widget.id, row);
    print('Update Produc ID: $id $row');
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
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: Color.fromRGBO(60, 56, 67, 1.0),
      ),
      backgroundColor: Color.fromRGBO(255, 252, 231, 1.0),
      body: FutureBuilder(
        future: getProduct(widget.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Pic(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new TextFormField(
                            initialValue: _nameProduct,
                            decoration: const InputDecoration(
                              labelText: 'Name of product',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            onChanged: (text) {
                              var val = text;
                              if (val != null) {
                                _nameProduct = val;
                              } 
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: new TextFormField(
                                    initialValue: _amount.toString(),
                                    decoration: const InputDecoration(
                                      labelText: 'Number of product',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) {
                                      var val = int.tryParse(text);
                                      if (val != null) {
                                        _amount = val;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: "Select Category",
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _category,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    onChanged: (String newValue) {
                                      _category = newValue;
                                    },
                                    items: <String>['Product', 'Box']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: new TextFormField(
                                    initialValue: _retailPrice.toString(),
                                    decoration: const InputDecoration(
                                      labelText: 'Retail Price(Baht)',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) {
                                      var val = int.tryParse(text);
                                      if (val != null) {
                                        _retailPrice = val;
                                      }
                                    },
                                    inputFormatters: [
                                      ThousandsFormatter(allowFraction: true)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: new TextFormField(
                                    initialValue: _wholesalePrice.toString(),
                                    decoration: const InputDecoration(
                                      labelText: 'Wholesale Price(Baht)',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) {
                                      var val = int.tryParse(text);
                                      if (val != null) {
                                        _wholesalePrice = val;
                                      }
                                    },
                                    inputFormatters: [
                                      ThousandsFormatter(allowFraction: true)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new TextFormField(
                            initialValue: _detail,
                            decoration: const InputDecoration(
                              labelText: 'Detail',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (text) {
                              var val = text;
                              if (val != null) {
                                _detail = val;
                              }
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              updateProduct();
                              setState(() {
                                
                              });
                            },
                            // style: ElevatedButton.styleFrom(
                            //   primary: Colors.green,
                            //   onPrimary: Colors.white,
                            // ),
                            child: Text("Edit")),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
