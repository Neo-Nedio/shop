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

  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  //获取轮播图
  Widget _getSlider(){

    //获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
        carouselController: _controller,
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
            autoPlayInterval: Duration(seconds: 5),
            //改变索引
            onPageChanged: (int index,reason){
              _currentIndex = index;
              setState(() {});
    }
        )
    );
  }

  Widget _getSearch(){
    return Positioned(
        top: 10,
        left: 0,
        right: 0,
        child: Padding(
            padding:EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                    borderRadius: BorderRadius.circular(25)
              ),
              child: Text(
                "搜索...",
                style: TextStyle(color: Colors.white,fontSize: 16),
              ),
        )
      )
    );
  }


  //返回指示灯导航部件
  Widget _getDots(){
    return Positioned(
        left: 0,
        right: 0,
        bottom: 10,
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.bannerList.length, (int index) {
              return GestureDetector(
                  onTap: (){
                    _controller.animateToPage(index);
                  },
                  child: AnimatedContainer(
                    //带动画的Container的动画间隔
                    duration: Duration(milliseconds: 300),
                    height: 6,
                    //根据索引改变长度
                    width: index == _currentIndex ? 40 : 20,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      //根据索引改变颜色
                        color: index == _currentIndex
                            ? Colors.white
                            : Color.fromRGBO(0, 0, 0, 0.3),
                        borderRadius: BorderRadius.circular(3)
                    ),
                  )
              );
            }),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getSlider(),
        _getSearch(),
        _getDots()
      ],
    );
    /*return Container(
        height: 300,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text("轮播图"));*/
  }
}
