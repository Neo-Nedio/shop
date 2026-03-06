import 'package:shop/Constants/Constants.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewModels/Home.dart';

Future<GoodsDetailsItems> getGuessListAPI (Map<String,dynamic> params) async{
  return GoodsDetailsItems.formJson(
      await dioRequest.get(HttpConstants.GUESS_LIST,params: params)
  );
}