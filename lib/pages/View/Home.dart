import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/components/Home/Category.dart';
import 'package:shop/components/Home/Hot.dart';
import 'package:shop/components/Home/MoreList.dart';
import 'package:shop/components/Home/Slider.dart';
import 'package:shop/components/Home/Suggestion.dart';
import 'package:shop/viewModels/Home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final List<BannerItem> _bannerList = [
    BannerItem(
      id : "1",
      imgUrl:"https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"
    ),
    BannerItem(
        id : "2",
        imgUrl:"https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png"
    ),
    BannerItem(
        id : "3",
        imgUrl:"https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"
    )
  ];


  List<Widget> _getScrollChildren(){
    return [
      //轮播图
      SliverToBoxAdapter(child: ShopSlider(bannerList: _bannerList)),

      //间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      //横向滚动-分类
      SliverToBoxAdapter(child: Category()),

      //间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      //推荐
      SliverToBoxAdapter(child: Suggestion()),

      //间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      //爆款推荐
      SliverToBoxAdapter(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(child: Hot()),
            SizedBox(width: 10),
            Expanded(child: Hot()),
          ],
        ),
        )
      ),

      //间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      //无限列表
      MoreList()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers : _getScrollChildren());
  }
}
