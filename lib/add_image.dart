import 'dart:io';
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
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
    // final appDir = await syspaths.getApplicationDocumentsDirectory();    
    // final fileName = path.basename(image.path);    
    // final savedImage = await image.copy('${appDir.path}/$fileName');
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          borderRadius: BorderRadius.circular(25)
                          ),
                      width: 200,
                      height: 200,
                      child: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.grey[800],
                        size: 200,
                      ),
                    ),
              ),
          ),
        )
      ],
    );
  }
}
