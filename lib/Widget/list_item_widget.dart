import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:sokoV3/model/list_item.dart';
import 'package:sokoV3/Searchbar.dart';
import '../detail_item.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const ListItemWidget({
    @required this.item,
    this.animation,
    this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => buildItem(context);

  Widget buildItem(BuildContext context) => GestureDetector(
    onTap:(){print('yay');
      String query;
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailItem(query)));},

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
            backgroundImage: NetworkImage(item.urlImage),
          ),
          title: Text(
            item.title,
            style: TextStyle(fontSize: 20, color: Colors.black),
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
  width: 40,height: 40,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(64),color: Colors.black),
  child:   PopupMenuButton<int>(
  
            child: Icon(Icons.more_vert,color: Colors.white),
            onSelected:(int value) {
              
              print(value);
              if(value == 1){
              
              showDialog(context: context,builder: (_) => AlertDialog(title: Text("เพิ่ม/ลด สินค้า"),));
              }else if(value == 2){
                //  Navigator.of(context).pushNamed(route)
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondRoute()),)
              }else if(value == 3){
                showDialog(context: context,builder: (_) => AlertDialog(
                  title: Text("ลบสินค้า"),
                  content: Text("ต้องการลบสินค้านี้หรือไม่ ?"),
                  actions: [
                    TextButton(child:Text("ใช่! ฉันต้องการลบ"),onPressed: (){},),
                    TextButton(child:Text("ยกเลิก"),onPressed: (){},),
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


//   Widget buildItem() => Container(
//     width: double.infinity,
//     height: 100,
//     margin: EdgeInsets.all(8),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(12),
//       color: Colors.red),
//     child: item.urlImage != null?
//       // ListTile(
//       // contentPadding: EdgeInsets.all(16),
//       // leading: CircleAvatar(radius: 32,
//       // backgroundImage: NetworkImage(item.urlImage),
//       // ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,

//             children: [ Container(margin: const EdgeInsets.only(left:10), child: ClipRRect(child: Image.network(item.urlImage,width: 70,height: 70,),borderRadius: BorderRadius.circular(64),)),

//           Container(
//             margin: const EdgeInsets.only(left: 25),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(item.title),
//                 Text('item.count'),
//               ],
//             ),
//           ),],
//           ),

//           Container(margin: const EdgeInsets.only(right: 20), child: Icon(Icons.delete,color: Colors.black,size: 32,),
//           ),

//         ],
//       )
//     : CircularProgressIndicator(),
//   );




}