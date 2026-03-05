import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/api/Home.dart';
import 'package:shop/components/Home/Category.dart';
import 'package:shop/components/Home/Hot.dart';
import 'package:shop/components/Home/MoreList.dart';
import 'package:shop/components/Home/Slider.dart';
import 'package:shop/components/Home/Suggestion.dart';
import 'package:shop/utils/ToastUtils.dart';
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

  //页码
  int _page = 1;
  //加载情况
  bool _isLoading = false;
  //是否还有下一页
  bool _hasMore = true;



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
  Future<void> _getBannerList() async{
    _bannerList = await getBannerListAPI();
  }

  //获取分类列表
  Future<void> _getCategoryList() async{
    _categoryList = await getCategoryListAPI();
  }

  //获取特惠推荐
  Future<void> _getSpecialOfferList() async{
    _specialOfferResult = await getSpecialOfferListAPI();
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    //正在请求 或 没有下一页 ,放弃请求
    if(_isLoading || !_hasMore) {return;}
    _isLoading = true;

    //limit是网络请求的参数，用来控制传回数据的多少
    int RequestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({"limit": RequestLimit});

    //请求结束后处理
    _isLoading = false;
    _page++;
    setState(() {});
    if(_recommendList.length < RequestLimit) {
        _hasMore = false;
        return;
      }
  }

  //监听滚动到底部的事件
  void _registerEvent(){
    _controller.addListener((){
      //加载下一页数据
      if(_controller.position.pixels == (_controller.position.maxScrollExtent)) {
        _getRecommendList();
      }
    });
  }

  //刷新函数
  Future<void> _onRefresh() async{
     _page = 1;
     _isLoading = false;
     _hasMore = true;
     await _getBannerList();
     await _getCategoryList();
     await _getSpecialOfferList();
     await _getInVogueList();
     await _getOneStopList();
     await _getRecommendList();
     //获取数据成功
     ToastUtils.showToast(context, "刷新成功");

     //将前面获取数据的方法进行统一刷新(获取推荐列表除外,因为其在下拉刷新外还有上拉刷新)
     setState(() {});
  }

  @override
  void initState() {
    super.initState();

    /*_getBannerList();
    _getCategoryList();
    _getSpecialOfferList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();*/

    _registerEvent();
    //initState -> build ,此时RefreshIndicator才被创建并使用
    //用微任务异步,等build之后再刷新
    Future.microtask((){
      _key.currentState?.show();
    });

    //还可以直接调用 _onRefresh(); 刷新,只是缺少了动画
  }

  final ScrollController _controller = ScrollController();

  //GlobalKey可以创建一个key绑定到widget上进行操作
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //可用于刷新的组件
    return RefreshIndicator(
        key: _key,
        onRefresh: _onRefresh,
        child:  CustomScrollView(
          controller: _controller,
          slivers : _getScrollChildren()
          )
        );
  }
}
