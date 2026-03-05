import 'package:shop/Constants/Constants.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewModels/Home.dart';

Future<List<BannerItem>> getBannerListAPI() async{

  return (await (dioRequest.get(HttpConstants.BANNER_LIST)) as List)
      .map((item) =>BannerItem.formJson(item as Map<String,dynamic>))
      .toList();
}

// 分类列表
Future<List<CategoryItem>> getCategoryListAPI() async{
  return (await (dioRequest.get(HttpConstants.CATEGORY_LIST)) as List)
      .map((item) =>CategoryItem.formJson(item as Map<String,dynamic>))
      .toList();
}