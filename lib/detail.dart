
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokoV3/test.dart';

class Detailpage extends StatefulWidget {
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
 TextEditingController _controller = TextEditingController();
  File _image;

  var ImagePicker;
  var ImageSource;
  @override
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
  void initState(){
        _controller.text = "0"; 
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Field increment decrement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            width: 60.0,
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.blueGrey,
                width: 2.0,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    controller: _controller,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                Container(
                  height: 38.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: InkWell(
                          child: Icon(
                            Icons.add,
                            size: 18.0,
                          ),
                          onTap: () {
                            int currentValue = int.parse(_controller.text);
                            setState(() {
                              currentValue++;
                              _controller.text = (currentValue)
                                  .toString(); // incrementing value
                            });
                          },
                        ),
                      ),
                      InkWell(
                        child: Icon(
                          Icons.remove,
                          size: 18.0,
                        ),
                        onTap: () {
                          int currentValue = int.parse(_controller.text);
                          setState(() {
                            print("Setting state");
                            currentValue--;
                            _controller.text =
                                (currentValue > 0 ? currentValue : 0)
                                    .toString(); // decrementing value
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
<<<<<<< HEAD
      floatingActionButton: FloatingActionButton(
        onPressed:(){ Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=> Pic()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
=======
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              child: Column(
                children: <Widget>[
                  TextField(
              onChanged: (text){
              },
              decoration: InputDecoration(
                labelText: "เพิ่มจำนวน",
                border: OutlineInputBorder(),
              ),
            )
                ],),
            ),
          ],
        ), 
>>>>>>> f3f815fbc6ee61d214f04b2331fe601c3924c888
      ),
    );
  }
}