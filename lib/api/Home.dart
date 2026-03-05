import 'package:shop/Constants/Constants.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewModels/Home.dart';

Future<List<BannerItem>> getBannerListAPI() async{

  return (await (dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((item) {
    return BannerItem.formJson(item as Map<String,dynamic>);
  }).toList();
}