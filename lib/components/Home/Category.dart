import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    //不能直接ListView,ListView不能设置高度
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context , int index){
            return Container(
              width: 80,
              height: 100,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.blue,
              child: Text("分类$index"),
            );
          }
          ),
    );
  }
}
