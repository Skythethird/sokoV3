import 'package:flutter/material.dart';

class DetailItem extends StatefulWidget {
  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Item'),
        backgroundColor: Color(0xff3D3D3D),
      ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
              ),
              Row(
                // mainAxisSize: MainAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.network("https://f.btwcdn.com/store-34660/product/39ebc6bf-499c-33dd-e649-5b8feb151781.jpg",height: 200,width: 200,)],
                ),
                Container(
                margin: EdgeInsets.all(8),
                child: Text("item name",style: TextStyle(fontSize: 28),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("จำนวน: "),
                ),
                 Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("รายละเอียด "),
                ),
            ],
          ),
        ),
    );
  }
}