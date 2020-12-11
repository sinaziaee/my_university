class Order {
  String name;
  int price;
  String image;
  int number;
  int serveId;

  Order({this.image, this.name, this.price, this.number, this.serveId});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['serve_id'] = serveId;
    map['count'] = number;
    map['name'] = name;
    map['price'] = price;
    map['image'] = image;
    return map;
  }
}
