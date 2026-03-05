import 'package:flutter/material.dart';
import 'package:shop/viewModels/Home.dart';

class Category extends StatefulWidget {
  //分类列表
  final List<CategoryItem> categoryList;
  const Category({super.key, required this.categoryList});

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
          itemCount: widget.categoryList.length,
          itemBuilder: (BuildContext context , int index){
            //获取分类列表
            final categoryItem = widget.categoryList[index];
            return Container(
              width: 80,
              height: 100,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(categoryItem.picture,width: 40,height: 40,),
                  Text(categoryItem.name,style: TextStyle(color: Colors.black)),
                ],
              ),
            );
          }
          ),
    );
  }
}
