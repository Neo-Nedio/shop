import 'package:shop/components/Home/Category.dart';

class GlobalConstants {
  static const String BASE_URL = "https://meikou-api.itheima.net";
  static const int TIME_OUT = 10;
  static const String SUCCESS_CODE = "1";
}

class HttpConstants {
  static const String BANNER_LIST = "/home/banner";
  static const String CATEGORY_LIST = "/home/category/head";//分类
  static const String PRODUCT_LIST = "/hot/preference";//商品列表
  static const String IN_VOGUE_LIST = "/hot/inVogue"; // 热榜推荐地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; // 一站式推荐地址

}