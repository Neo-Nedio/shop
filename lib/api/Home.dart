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

//特惠推荐(并不是返回List)
Future<SpecialOfferResult> getSpecialOfferListAPI() async{
  return SpecialOfferResult.formJson(
    await dioRequest.get(HttpConstants.PRODUCT_LIST));
}

// 热榜推荐
Future<SpecialOfferResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialOfferResult.formJson(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecialOfferResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialOfferResult.formJson(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}