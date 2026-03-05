class BannerItem{
  String id;
  String imgUrl;

  BannerItem({required this.id,required this.imgUrl});

  //工厂函数,用来创建实例对象
  factory BannerItem.formJson(Map<String,dynamic> json){
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }

}