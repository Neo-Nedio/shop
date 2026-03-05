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

  //特惠推荐
  SpecialOfferResult _specialOfferResult = SpecialOfferResult(
    id: "", title: "", subTypes: []);

  // 热榜推荐
  SpecialOfferResult _inVogueResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialOfferResult _oneStopResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];



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
      SliverToBoxAdapter(child: Suggestion(specialOfferResult: _specialOfferResult)),

      //间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      //爆款推荐
      SliverToBoxAdapter(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
              Expanded(
                child: Hot(result: _inVogueResult, type: "hot"),
              ),

              SizedBox(width: 10),

              Expanded(
                child: Hot(result: _oneStopResult, type: "step"),
              ),
          ],
        ),
        )
      ),

      //间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      //无限列表
      MoreList(recommendList: _recommendList), // 无限滚动列表
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

  //获取特惠推荐
  void _getSpecialOfferList() async{
    _specialOfferResult = await getSpecialOfferListAPI();
    setState(() {});
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  // 获取推荐列表
  void _getRecommendList() async {
    //limit是网络请求的参数，用来控制传回数据的多少
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getSpecialOfferList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers : _getScrollChildren());
  }
}
