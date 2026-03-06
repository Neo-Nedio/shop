import 'package:get/get.dart';
import 'package:shop/viewModels/User.dart';

class UserController extends GetxController {
  //.obs：将普通变量转换为可观察对象，当 .value 改变时，会自动通知所有使用了该变量的组件更新。
    var user = UserInfo.fromJSON({}).obs;

    updateUserInfo(UserInfo newUser){
      //从user.value中才能取值
      user.value =newUser;
    }
}

/*
登录页 (Login.dart)                   个人中心页 (Mine.dart)
|                                       |
|--- Get.find<UserController>()         |--- Get.put<UserController>()
|        (获取已有实例)                  |        (首次初始化)
|                                       |
v                                       v
┌─────────────────┐                  ┌─────────────────┐
│ UserController  │                  │ UserController  │
│  (单例)         │<-----------------│  (同一个实例)   │
└─────────────────┘                  └─────────────────┘
|
|  user.value 改变时自动通知
↓
┌─────────────────────────────────────────────────┐
│ 所有 Obx 监听者自动重建 (如头像、欢迎语)          │
└─────────────────────────────────────────────────┘*/
