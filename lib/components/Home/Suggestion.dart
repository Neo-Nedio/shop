import 'package:flutter/material.dart';
import 'package:shop/viewModels/Home.dart';

class Suggestion extends StatefulWidget {
  //特惠推荐
  final SpecialOfferResult specialOfferResult;
  const Suggestion({super.key, required this.specialOfferResult});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: Color.fromARGB(255,86,24,20),
            fontSize: 18,
            fontWeight: FontWeight.w700
          ),
        ),

        SizedBox(width: 10,),

        Text(
          "精选省攻略",
          style: TextStyle(
            color: Color.fromARGB(255,124,63,58),
            fontSize: 12
          ),
        )
      ],
    );
  }

  //左侧结构
  Widget _buildLeft(){
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover
        )
      ),
    );
  }

  //取三条数据
  List<GoodsItem> _getDisplayItems(){
    //防止刚开始时没有获取到数据，访问报错
    if(widget.specialOfferResult.subTypes.isEmpty) return [];
    return widget.specialOfferResult.subTypes.first.goodsItems.items
    .take(3)
    .toList();
  }

  List<Widget> _getChildrenList(){
    List<GoodsItem> list = _getDisplayItems();
    return List.generate(list.length,(int index){
      return Column(
        children: [
          //ClipRRect 可以包裹子元素 裁剪图片设置圆角
          ClipRRect(
            child: Image.network(
              
              //防止图片加载失败
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "lib/assets/home_cmd_inner.png",
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                );
              },

              list[index].picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 10,),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 240, 96, 12)
            ),
            child: Text(
              "￥${list[index].price}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_sm.png"),
          fit : BoxFit.cover)
      ),
      child: Column(
        children: [
          //顶部内容
          _buildHeader(),

          SizedBox(height: 10,),

          //主体内容
          Row(children: [
            _buildLeft(),

            Expanded(child: 
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList()
              )
            )
          ],)
        ],
      ))
    );
  }
}
