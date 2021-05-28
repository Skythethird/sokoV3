import 'dart:ffi';
import 'dart:io';

import 'package:barcode_image/barcode_image.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';


class BarcodeGen extends StatefulWidget {
  @override
  _BarcodeGenState createState() => _BarcodeGenState();
}

class _BarcodeGenState extends State<BarcodeGen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
        backgroundColor: Color.fromRGBO(60, 56, 67, 1.0),
      ),
      backgroundColor: Color.fromRGBO(255, 252, 231, 1.0),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BarcodeWidget(
            barcode: Barcode.code128(),
            data: controller.text ?? 'Hello World',
            width: 200,
            height: 200,
            drawText: false, 
            ),
            SizedBox(height: 24),
            Row(
                  children: [
                    Expanded(child: buildTextField(context)),
                    const SizedBox(width: 12),
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.done, size: 30),
                      onPressed: () => setState(() {}),
                    )
                  ],
                ),
            FloatingActionButton(
                  child: Text(
                        "Save QR Code",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: (){
                        //How to save screenshots
                    // _widgetShot();
                  },
                )

        ],
        ),
    ),
      ),
    );

  }
  Widget buildTextField(BuildContext context) => TextField(
         controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: 'Enter the data',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
}