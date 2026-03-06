import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/Constants/Constants.dart';

class TokenManager {
  //返回持久化实例对象
  Future<SharedPreferences> _getInstance(){
    return SharedPreferences.getInstance();
  }

  String _token = "";

  Future<void> init() async{
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  Future<void> set(String val) async{
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }

  String get() {
    return _token;
  }

  Future<void> remove() async{
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}


//构造单例
final tokenManager = TokenManager();