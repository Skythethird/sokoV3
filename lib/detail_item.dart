import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokoV3/edit_items.dart';

class DetailItem extends StatefulWidget {
  DetailItem(String items);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  String items;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Item'),
        actions: [
          // Padding(
          //     padding: const EdgeInsets.only(right: 10),
          //     child: GestureDetector(
          //       // onTap: () {
          //       //   Navigator.push(
          //       //       context,
          //       //       MaterialPageRoute(
          //       //           builder: (context) => AddNewProductPage()));
          //       // },
          //       child: Icon(Icons.more_vert),
          //     ))

          PopupMenuButton<int>(
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: Icon(Icons.more_vert, size: 32, color: Colors.white)),
            onSelected: (int value) {
              print(value);
              if (value == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProductPage()));
              } else if (value == 2) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("ลบสินค้า"),
                          content: Text("ต้องการลบสินค้านี้หรือไม่ ?"),
                          actions: [
                            TextButton(
                              child: Text("ใช่! ฉันต้องการลบ"),
                              onPressed: () {},
                            ),
                            TextButton(
                              child: Text("ยกเลิก"),
                              onPressed: () {},
                            ),
                          ],
                          elevation: 24.0,
                        ));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 35,
                      color: Colors.blue[300],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "แก้ไข",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 35,
                      color: Colors.red,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "ลบ",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Color(0xff3D3D3D),
      ),
      backgroundColor: Color.fromRGBO(255, 252, 231, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
              ),
              Row(
                // mainAxisSize: MainAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      "https://f.btwcdn.com/store-34660/product/39ebc6bf-499c-33dd-e649-5b8feb151781.jpg",
                      height: 200,
                      width: 200,
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  'name',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "จำนวน: ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border(
                    top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                    left: BorderSide(width: 1.0, color: Color(0xFF000000)),
                    right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                    bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
                  ),
                ),
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "รายละเอียด ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: Text(
                          "awfafaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      title: Text("เพิ่มจำนวนสินค้า"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                          width: 100.0,
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
                                          int currentValue =
                                              int.parse(_controller.text);
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
                                        int currentValue =
                                            int.parse(_controller.text);
                                        setState(() {
                                          print("Setting state");
                                          currentValue--;
                                          _controller.text = (currentValue > 0
                                                  ? currentValue
                                                  : 0)
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
                      ]),
                      actions: [
                          TextButton(
                            child: Text("Cancel",style: TextStyle(fontSize: 20, color: Colors.red),),
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                          ),
                          TextButton(
                            child: Text("Cofirm",style: TextStyle(fontSize: 20, color: Colors.green),),
                            onPressed: () {},
                          ),
                        ],
                      )).then((value) => {_controller.text = '0'});
                    },
                    child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_circle_up,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.all(8),
                                      child: Text(
                                        "เพิ่มจำนวนสินค้า",
                                        style: TextStyle(fontSize: 15),
                                      )),
                                ],
                              )),

                          // Container(margin: const EdgeInsets.all(8), child: Text("เพิ่มจำนวนสินค้า",style: TextStyle(fontSize: 15),)),
                        ])),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      title: Text("ลดจำนวนสินค้า"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                          width: 100.0,
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
                                          int currentValue =
                                              int.parse(_controller.text);
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
                                        int currentValue =
                                            int.parse(_controller.text);
                                        setState(() {
                                          print("Setting state");
                                          currentValue--;
                                          _controller.text = (currentValue > 0
                                                  ? currentValue
                                                  : 0)
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
                      ]),
                      actions: [
                          TextButton(
                            child: Text("Cancel",style: TextStyle(fontSize: 20, color: Colors.red),),
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                          ),
                          TextButton(
                            child: Text("Cofirm",style: TextStyle(fontSize: 20, color: Colors.green),),
                            onPressed: () {},
                          ),
                        ],
                      )).then((value) => {_controller.text = '0'});
                    },
                    child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_down,
                                      size: 32,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: Text(
                                        "ลดจำนวนสินค้า",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                )),
                            // Container(margin: const EdgeInsets.all(8), child: Text("ลดจำนวนสินค้า",style: TextStyle(fontSize: 15),),),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _simplePopup(BuildContext context) => Container(
  //       width: 40,
  //       height: 40,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(64), color: Colors.black),
  //       child: PopupMenuButton<int>(
  //         child: Icon(Icons.more_vert, color: Colors.white),
  //         onSelected: (int value) {
  //           print(value);
  //            if (value == 1) {
  //             //  Navigator.of(context).pushNamed(route)
  //             Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => EditProductPage()));

  //           } else if (value == 2) {
  //             showDialog(
  //                 context: context,
  //                 builder: (_) => AlertDialog(
  //                       title: Text("ลบสินค้า"),
  //                       content: Text("ต้องการลบสินค้านี้หรือไม่ ?"),
  //                       actions: [
  //                         TextButton(
  //                           child: Text("ใช่! ฉันต้องการลบ"),
  //                           onPressed: () {},
  //                         ),
  //                         TextButton(
  //                           child: Text("ยกเลิก"),
  //                           onPressed: () {},
  //                         ),
  //                       ],
  //                       elevation: 24.0,
  //                     ));
  //           }
  //         },
  //         itemBuilder: (context) => [
  //           // PopupMenuItem(
  //           //   value: 1,
  //           //   child: Text("เพิ่ม/ลด สินค้า"),
  //           // ),
  //           PopupMenuItem(
  //             value: 1,
  //             child: Text("แก้ไข"),
  //           ),
  //           PopupMenuItem(
  //             value: 2,
  //             child: Text("ลบ"),
  //           ),
  //         ],
  //       ),
  //     );
}
