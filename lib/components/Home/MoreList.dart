import 'package:flutter/material.dart';

class MoreList extends StatefulWidget {
  const MoreList({super.key});

  @override
  State<MoreList> createState() => _MoreListState();
}

class _MoreListState extends State<MoreList> {
  @override
  Widget build(BuildContext context) {
    //用Sliver家族组件才能放入
    return SliverGrid.builder(
      //两列网格
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing:  10,
            crossAxisSpacing: 10),
        itemBuilder: (BuildContext context,int index){
          return Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text("商品"));
        });
  }
}
