import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/viewModels/Home.dart';

class ShopSlider extends StatefulWidget {

  final List<BannerItem> bannerList;
  const ShopSlider({super.key, required this.bannerList});

  @override
  State<ShopSlider> createState() => _SliderState();
}

class _SliderState extends State<ShopSlider> {

  Widget _getSlider(){

    //获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
        items: List.generate(widget.bannerList.length, (int index){
          return Image.network(widget.bannerList[index].imgUrl,
            //让图片覆盖整个容器，同时保持原始宽高比
            fit: BoxFit.cover,
            //设置图片宽度为屏幕宽度
            width: screenWidth,);
        }),
        options: CarouselOptions(
          //视口占比为100%，即一图占一个视图
            viewportFraction: 1,
            //自动播放
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getSlider(),
      ],
    );
    /*return Container(
        height: 300,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text("轮播图"));*/
  }
}
