import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../database_helper.dart';
import 'package:focused_menu/modals.dart';
import 'package:sokoV3/model/list_item.dart';
import 'package:sokoV3/edit_items.dart';
import '../detail_item.dart';

class ListItemWidget extends StatefulWidget {
  final item;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const ListItemWidget({
    @required this.item,
    this.animation,
    this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) => buildItem(context);

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = "0";
    super.initState();
  }

  Widget buildItem(BuildContext context) => GestureDetector(
        onTap: () {
          print('yay');
          String query;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailItem(query)));
        },
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage('https://home.maefahluang.org/images/editor/apple.jpg'),
            ),
            title: Column(
              children: [
                Text(
                  widget.item['productname'],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  widget.item['amount'].toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            trailing: _simplePopup(context),
            // trailing: IconButton(
            //   onPressed: _simplePopup,

            //       icon: Icon(
            //         Icons.more_horiz,
            //         color: Colors.black,
            //         size: 32,
            //       ),

            //     ),
          ),
        ),
      );

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
            } else if (value == 2) {
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
            } else if (value == 3) {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProductPage()));

            } else if (value == 4) {
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
              child: Text("เพิ่มจำนวนสินค้า"),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("ลดจำนวนสินค้า"),
            ),
            PopupMenuItem(
                value: 3,
                child: Text("แก้ไข"),
                
              ),
            PopupMenuItem(
              value: 4,
              child: Text("ลบ"),
            ),
          ],
        ),
      );
}