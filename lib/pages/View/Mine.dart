import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:shop/components/Home/MoreList.dart';
import 'package:shop/components/Mine/Guess.dart';
import 'package:shop/stores/TokenManager.dart';
import 'package:shop/stores/UserController.dart';
import 'package:shop/viewModels/User.dart';

import '../../api/Mine.dart';
import '../../viewModels/Home.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {

  final UserController _userController = Get.find();

  //退出登录
  Widget _getLogout(){
      return _userController.user.value.id.isNotEmpty
        ? Expanded(
          child: GestureDetector(
            onTap: (){
              //弹出确认提示框
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("提示"),
                      content: Text("确认退出登录吗"),
                      actions: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text("取消")
                        ),
                        TextButton(
                            onPressed: () async{
                              //删除GetX和token
                              await tokenManager.remove();
                              _userController.updateUserInfo(
                                UserInfo.fromJSON({})//通过空Map,构造空的UserInfo
                              );
                              Navigator.pop(context);
                          },
                            child: Text("确认")
                        ),
                      ],
                    );
                  }
              );
            },
            child: Text("退出",textAlign: TextAlign.end,),
          )
      )
      :Text("");
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        //用 LinearGradient 创建渐变背景的代码
        gradient: LinearGradient(
            begin: Alignment.topCenter,        // 渐变起点：顶部中心
            end: Alignment.bottomCenter,        // 渐变终点：底部中心
            colors: [
              const Color(0xFFFFF2E8),  // 起始颜色：浅米色/奶油色
              const Color(0xFFFDF6F1),  // 结束颜色：更浅的米白色
            ],
        ),
      ),
      //内边距：左上右下分别是20、40、80、20像素
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
         /* Obx：这是一个响应式包装器，它会自动监听内部使用的所有可观察变量（如 _userController.user）。
          当这些变量的 .value 改变时，Obx 会重新执行其 builder 函数，更新 UI。
          自动刷新：当用户在登录页登录后，_userController.user.value 被更新，
          此时 MineView 中的两个 Obx 会自动重建，显示最新的用户信息。*/
          Obx((){
            return CircleAvatar(
              radius: 26,                           // 半径26像素
              backgroundImage:
              _userController.user.value.id.isNotEmpty
              ? NetworkImage(_userController.user.value.avatar)
              : AssetImage('lib/assets/goods_avatar.png'),
              backgroundColor: Colors.white,         // 背景色（图片加载失败时显示）
            );
          }),
          // CircleAvatar 是 Flutter 中的一个用于显示圆形头像的组件。它通常用来展示用户头像、联系人图片


          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Obx必须有可监测的响应式数据
                Obx((){
                  return GestureDetector(
                    onTap: (){
                      //没有用户信息时可登录
                      if(_userController.user.value.id.isEmpty){
                        Navigator.pushNamed(context, "/login");
                      }
                    },
                    child: Text(
                      _userController.user.value.id.isNotEmpty
                      ? _userController.user.value.account
                      : '立即登录',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                })
              ],
            ),
          ),

          //检测是否登录，用于查看是否可退出
          Obx( () => _getLogout())
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '升级美荟商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", '我的收藏'),
            item("lib/assets/ic_user_history.png", '我的足迹'),
            item("lib/assets/ic_user_unevaluated.png", '我的客服'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderModule() {
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //Card 是 Flutter 中的一个 Material Design 卡片组件，用于创建一个带有圆角、阴影的容器，通常用来展示相关信息块
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的订单',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", '全部订单'),
                  orderItem("lib/assets/ic_user_obligation.png", '待付款'),
                  orderItem("lib/assets/ic_user_unreceived.png", '待发货'),
                  orderItem("lib/assets/ic_user_unshipped.png", '待收货'),
                  orderItem("lib/assets/ic_user_unevaluated.png", '待评价'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<GoodDetailItem> _list = [];

  Map<String,dynamic> _params = {"page" : 1,"pageSize" :10};

  //加载情况
  bool _isLoading = false;
  //是否还有下一页
  bool _hasMore = true;

  Future<void> _getGuessList() async{
      if(_isLoading || !_hasMore) {return;}
      _isLoading = true;

      final res = await getGuessListAPI(_params);
      //请求带页数，所以每次数据只有那一页，应该追加而不是覆盖
      _list.addAll(res.items);

      _isLoading = false;
      setState(() {});
      if( _params["page"] >= res.page){
        _hasMore = false;
        return;
      }
      _params["page"]++;
  }

  //监听滚动到底部的事件
  void _registerEvent(){
    _controller.addListener((){
      //加载下一页数据
      if(_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getGuessList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getGuessList();
    _registerEvent();
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildOrderModule()),
        // 猜你喜欢
        SliverPersistentHeader(delegate: Guess(),pinned: true),
        MoreList(recommendList: _list)
      ],
    );
  }
}
