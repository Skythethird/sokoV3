
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test'),
      ),
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
      ),
      
    );
  }
}