
import 'package:flutter/material.dart';
import 'package:sokoV3/model/list_item.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const ListItemWidget({
   @required this.item,
   this.animation,
   this.onClicked,
    Key key,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return buildItem();
  }
  Widget buildItem() => Container(
    width: double.infinity,
    height: 100,
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.red),
    child: item.urlImage != null?
      // ListTile(
      // contentPadding: EdgeInsets.all(16),
      // leading: CircleAvatar(radius: 32,
      // backgroundImage: NetworkImage(item.urlImage),
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [ Container(margin: const EdgeInsets.only(left:10), child: ClipRRect(child: Image.network(item.urlImage,width: 70,height: 70,),borderRadius: BorderRadius.circular(64),)),
          
          Container(
            margin: const EdgeInsets.only(left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("juy"),
                Text("juy"),
              ],
            ),
          ),],
          ),
          
          Container(margin: const EdgeInsets.only(right: 20), child: Icon(Icons.menu)),
          
        ],
      )
    : CircularProgressIndicator(),
  );
}