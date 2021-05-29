import 'dart:ffi';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class BarcodeGen extends StatefulWidget {
  @override
  _BarcodeGenState createState() => _BarcodeGenState();
}

class _BarcodeGenState extends State<BarcodeGen> {
  final controller = TextEditingController();
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Barcode Generate'),
          backgroundColor: Color.fromRGBO(60, 56, 67, 1.0),
        ),
        backgroundColor: Color.fromRGBO(255, 252, 231, 1.0),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Screenshot(
                  controller: _screenshotController,
                  child: Card(
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: controller.text ?? 'Hello World',
                      width: 200,
                      height: 200,
                      drawText: false,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: buildTextField(context)),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Icon(Icons.save_alt_rounded, size: 30),
                        onPressed: _takeScreenshot,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 50,
                    width: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Icon(
                        Icons.done,
                        size: 30,
                      ),
                      // Text(
                      //       "Save Barcode Code",
                      //   style: TextStyle(
                      //     color: Colors.white
                      //   ),
                      // ),
                      onPressed: () => setState(() {}),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture();
    final result = await ImageGallerySaver.saveImage(imageFile,
        quality: 60, name: controller.text);
    print("File Saved to Gallery");
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
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.black),
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
