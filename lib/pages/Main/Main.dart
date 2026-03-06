import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:shop/pages/View/Cart.dart';
import 'package:shop/pages/View/Category.dart';
import 'package:shop/pages/View/Home.dart';
import 'package:shop/pages/View/Mine.dart';
import 'package:shop/stores/TokenManager.dart';

import '../../api/User.dart';
import '../../stores/UserController.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  //导航资源列表
  final List<Map<String,String>> _tabsList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "首页"
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类"
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车"
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的"
    }
    ];

  //页面索引
  int _currentIndex = 0 ;

  //返回底部渲染的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget()
  {
    return List.generate(_tabsList.length, (int index){
      return BottomNavigationBarItem(
          icon: Image.asset(
            _tabsList[index]["icon"]!,
            width: 30,
            height: 30,
          ),

          activeIcon: Image.asset(
          _tabsList[index]["active_icon"]!,
          width: 30,
          height: 30,
          ),

          label:_tabsList[index]["text"]!
      );
    });
  }

  List<Widget> _getChildren()
  {
    return [
      HomeView(),
      CategoryView(),
      CartView(),
      MineView()
    ];
  }

  // 初始化（如果已存在则返回现有实例）
  final UserController _userController = Get.put(UserController());

  void _initUser() async{
      await tokenManager.init();
      if(tokenManager.get().isNotEmpty){
        _userController.updateUserInfo(await gerUserInfoAPI());
      }
  }

  @override
  void initState() {

    super.initState();
    _initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //SafeArea避开安全区组件
      body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: _getChildren(),
          )),

      //底部导航
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          onTap: (int index)
          {
              _currentIndex = index;
              setState(() {});
          },
          items: _getTabBarWidget()),
    );
  }
}
