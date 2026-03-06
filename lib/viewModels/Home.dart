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

//特惠推荐数据
class SpecialOfferResult{
  String id;
  String title;
  List<SubType> subTypes;

  SpecialOfferResult({required this.id, required this.title, required this.subTypes});

  factory SpecialOfferResult.formJson(Map<String,dynamic> json){
    return SpecialOfferResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: json["subTypes"] != null
        ? (json["subTypes"] as List).map((item) => SubType.formJson(item as Map<String,dynamic>)).toList()
        : <SubType>[],
    );
  }
}

class SubType{
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.formJson(Map<String,dynamic> json){
    return SubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: GoodsItems.formJson(json["goodsItems"] ?? {}),
    );
  }
}

class GoodsItems{
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({required this.counts, required this.pageSize, required this.pages, required this.page, required this.items});

  factory GoodsItems.formJson(Map<String,dynamic> json){
    return GoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 1,
      items: json["items"] != null
        ? (json["items"] as List).map((item) => GoodsItem.formJson(item as Map<String,dynamic>)).toList()
        : <GoodsItem>[],
    );
  }
}

class GoodsItem{
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({required this.id, required this.name, this.desc, required this.price, required this.picture, required this.orderNum});

  factory GoodsItem.formJson(Map<String,dynamic> json){
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"],
      price: json["price"]?.toString() ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

//列表项类型
class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  // 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

//猜你喜欢
class GoodsDetailsItems{
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;

  GoodsDetailsItems({required this.counts, required this.pageSize, required this.pages, required this.page, required this.items});

  factory GoodsDetailsItems.formJson(Map<String,dynamic> json){
    return GoodsDetailsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 1,
      items: json["items"] != null
          ? (json["items"] as List).map((item) => GoodDetailItem.formJSON(item as Map<String,dynamic>)).toList()
          : <GoodDetailItem>[],
    );
  }
}

