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

  final dbHelper = DatabaseHelper.instance;

  void insertProduct() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnProductname: _nameProduct,
      DatabaseHelper.columnDetail: _detail,
      DatabaseHelper.columnAmount: _amount,
      DatabaseHelper.columnRetail: _retailPrice,
      DatabaseHelper.columnWholesale:_wholesalePrice,
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
        child: Column(
          children: <Widget>[
            Column(
              children: [Pic()],
            ),
            new TextFormField(
              decoration: const InputDecoration(labelText: 'Name of product'),
              keyboardType: TextInputType.text,
              onChanged: (String val) {
                _nameProduct = val;
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(labelText: 'Detail'),
              keyboardType: TextInputType.text,
              onChanged: (String val) {
                _detail = val;
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(labelText: 'Product Amount'),
              keyboardType: TextInputType.number,
              onChanged: (String val) {
                _amount = int.parse(val);
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(labelText: 'Retail Price'),
              keyboardType: TextInputType.number,
              onChanged: (String val) {
                _retailPrice = double.parse(val);
              },
              inputFormatters: [ThousandsFormatter(allowFraction: true)],
            ),
            new TextFormField(
              decoration: const InputDecoration(labelText: 'Wholesale Price'),
              keyboardType: TextInputType.number,
              onChanged: (String val) {
                _wholesalePrice = double.parse(val);
              },
              inputFormatters: [ThousandsFormatter(allowFraction: true)],
            ),
            DropdownButton<String>(
              value: _category,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
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
            ElevatedButton(
                onPressed: () {
                  insertProduct();
                  // _detail = "4512";
                },
                child: Text("Submit"))
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
