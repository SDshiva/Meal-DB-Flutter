class Items {
  final List<Item> items;

  Items({required this.items});

  factory Items.fromJson(Map<String, dynamic> json) {
    var list = json['categories'] as List;
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();
    return Items(items: itemsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class Item {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  Item(
      {required this.idCategory,
      required this.strCategory,
      required this.strCategoryThumb,
      required this.strCategoryDescription});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        idCategory: json['idCategory'],
        strCategory: json['strCategory'],
        strCategoryThumb: json['strCategoryThumb'],
        strCategoryDescription: json['strCategoryDescription']);
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': idCategory,
      'strCategory': strCategory,
      'strCategoryThumb': strCategoryThumb,
      'strCategoryDescription': strCategoryDescription
    };
  }
}
