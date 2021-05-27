import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokoV3/add_image.dart';
import 'database_helper.dart';

class AddNewProductPage extends StatefulWidget {
  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _nameProduct;
  String _detail;
  int _amount;
  double _retailPrice;
  double _wholesalePrice;
  String _category;
  @override
  void initState() {
    _nameProduct = null;
    _detail = null;
    _amount = 0;
    _retailPrice = 0;
    _wholesalePrice = 0;
    _category = null;
    super.initState();
  }

  final dbHelper = DatabaseHelper.instance;

  void insertProduct() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnProductname: _nameProduct,
      DatabaseHelper.columnDetail: _detail,
      DatabaseHelper.columnAmount: _amount,
      DatabaseHelper.columnRetail: _retailPrice,
      DatabaseHelper.columnWholesale: _wholesalePrice,
      DatabaseHelper.columnCategory: _category
    };
    final id = await dbHelper.insert(row);
    print('Insert Produc ID: $id $row');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
        backgroundColor: Color(0xff3D3D3D),
      ),
      body: Container(
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
                  decoration: const InputDecoration(
                    labelText: 'Name of product',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    var val = text;
                    if (val != null) {
                      setState(() {
                        _nameProduct = val;
                      });
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
                          decoration: const InputDecoration(
                            labelText: 'Number of product',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            var val = int.tryParse(text);
                            if (val != null) {
                              setState(() {
                                _amount = val;
                              });
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
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _category = newValue;
                            });
                          },
                          items: <String>['Product', 'Box']
                              .map<DropdownMenuItem<String>>((String value) {
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
                          decoration: const InputDecoration(
                            labelText: 'Retail Price(Baht)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            var val = double.tryParse(text);
                            if (val != null) {
                              setState(() {
                                _retailPrice = val;
                              });
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
                          decoration: const InputDecoration(
                            labelText: 'Wholesale Price(Baht)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            var val = double.tryParse(text);
                            if (val != null) {
                              setState(() {
                                _wholesalePrice = val;
                              });
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
                  decoration: const InputDecoration(
                    labelText: 'Detail',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (text) {
                    var val = text;
                    if (val != null) {
                      setState(() {
                        _detail = val;
                      });
                    }
                  },
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       insertProduct();
              //       // _detail = "4512";
              //     },
              //     child: Text("Submit"))
              // new SizedBox(
              //   height: 10.0,
              // ),
              // new RaisedButton(
              //   onPressed: _validateInputs,
              //   child: new Text('Validate'),
              // )
            ],
          ),
        ),
      ),
    );
  }

//   void _validateInputs() {
//     if (_formKey.currentState.validate()) {
// //    If all data are correct then save data to out variables
//       _formKey.currentState.save();
//     } else {
// //    If all data are not valid then start auto validation.
//       setState(() {
//         _autoValidate = true;
//       });
//     }
//   }
}
