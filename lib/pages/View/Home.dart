import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/api/Home.dart';
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

  List<BannerItem> _bannerList = [];

  //分类列表
  List<CategoryItem> _categoryList = [];


  List<Widget> _getScrollChildren(){
    return [
      //轮播图
      SliverToBoxAdapter(child: ShopSlider(bannerList: _bannerList)),

      //间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      //横向滚动-分类
      SliverToBoxAdapter(child: Category(categoryList: _categoryList)),

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

  //获取轮播图列表
  void _getBannerList() async{
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  //获取分类列表
  void _getCategoryList() async{
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers : _getScrollChildren());
  }
}
