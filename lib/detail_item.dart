import 'package:flutter/material.dart';

class DetailItem extends StatefulWidget {
  DetailItem(String items);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  String items;

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
            child: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (int value) {
              print(value);
              if (value == 1) {
                //  Navigator.of(context).pushNamed(route)
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondRoute()),)
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
                child: Text(
                  "แก้ไข",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "ลบ",
                  style: TextStyle(color: Colors.red, fontSize: 18),
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
                  Container(
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
                  Container(
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _simplePopup(BuildContext context) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64), color: Colors.black),
        child: PopupMenuButton<int>(
          child: Icon(Icons.more_vert, color: Colors.white),
          onSelected: (int value) {
            print(value);
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("เพิ่ม/ลด สินค้า"),
                      ));
            } else if (value == 2) {
              //  Navigator.of(context).pushNamed(route)
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondRoute()),)
            } else if (value == 3) {
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
              child: Text("เพิ่ม/ลด สินค้า"),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("แก้ไข"),
            ),
            PopupMenuItem(
              value: 3,
              child: Text("ลบ"),
            ),
          ],
        ),
      );
}
