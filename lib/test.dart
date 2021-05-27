

import 'dart:io';
import 'package:sokoV3/add_new_product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Pic extends StatefulWidget {
  @override
  _PicState createState() => _PicState();
}

class _PicState extends State<Pic> {
  File _image;
  

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50
  );

  setState(() {
    _image = image;
  });
  }

  _imgFromGallery() async {
  File image = await  ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
  );

  setState(() {
    _image = image;
  });
  }
  @override
  void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
}
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Column(
      children: <Widget>[
        SizedBox(
          height: 12,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: Container(
              child: _image != null
                  ? ClipRRect(
                      
                      child: Image.file(
                        _image,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)
                          ),
                      width: 200,
                      height: 200,
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.grey[800],
                        size: 200,
                      ),
                    ),
              ),
            // child: CircleAvatar(
            //   radius: 55,
            //   backgroundColor: Color(0xffFDCF09),
            //   child: _image != null
            //       ? ClipRRect(
            //           borderRadius: BorderRadius.circular(50),
            //           child: Image.file(
            //             _image,
            //             width: 100,
            //             height: 100,
            //             fit: BoxFit.fitHeight,
            //           ),
            //         )
            //       : Container(
            //           decoration: BoxDecoration(
            //               color: Colors.grey[200],
            //               borderRadius: BorderRadius.circular(50)),
            //           width: 100,
            //           height: 100,
            //           child: Icon(
            //             Icons.add_photo_alternate_outlined,
            //             color: Colors.grey[800],
            //           ),
            //         ),
            // ),
          ),
        )
      ],
    ),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNewProductPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward_outlined),
      ),
  );
}
}