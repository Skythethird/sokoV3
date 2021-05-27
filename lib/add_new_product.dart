import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokoV3/add_image.dart';

class AddNewProductPage extends StatefulWidget {
  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _nameProduct;
  String _detail;
  int _numberProduct;
  double _retailPrice;
  double _wholesalePrice;
  String _category;
  @override
  void initState() {
    _nameProduct = null;
    _detail = null;
    _numberProduct = 0;
    _retailPrice = 0;
    _wholesalePrice = 0;
    _category = null;
    super.initState();
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
        child: Column(
          children: <Widget>[
            Column(
              children: [Pic()],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Detail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                      _numberProduct = val;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Retail Price',
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
                inputFormatters: [ThousandsFormatter(allowFraction: true)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Wholesale Price',
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
                inputFormatters: [ThousandsFormatter(allowFraction: true)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()),
                child: DropdownButton<String>(
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
            ElevatedButton(
                onPressed: () {
                  _detail = "4512";
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
