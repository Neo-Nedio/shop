import 'package:shop/Constants/Constants.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewModels/User.dart';

Future<UserInfo> loginAPI (Map<String,dynamic> data) async{
    return UserInfo.fromJSON(
      await dioRequest.post(HttpConstants.LOGIN,data: data)
    );
}

Future<UserInfo> gerUserInfoAPI() async{
  return UserInfo.fromJSON(
    await dioRequest.get(HttpConstants.USER_PROFILE)
  );
}