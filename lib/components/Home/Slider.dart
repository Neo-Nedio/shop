import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopSlider extends StatefulWidget {
  const ShopSlider({super.key});

  @override
  State<ShopSlider> createState() => _SliderState();
}

class _SliderState extends State<ShopSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text("轮播图"));
  }
}
