class BannerItem{
  String id;
  String imgUrl;

  BannerItem({required this.id,required this.imgUrl});

  //工厂函数,用来创建实例对象
  factory BannerItem.formJson(Map<String,dynamic> json){
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }

}

//根据json编写claas对象和工厂转化函数
//分类列表
class CategoryItem{
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
     this.children});

  factory CategoryItem.formJson(Map<String,dynamic> json){
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] != null ? 
      (json["children"] as List).map((item) => CategoryItem.formJson(item as Map<String,dynamic>))
      .toList() 
      : null,
    );
  }
}
