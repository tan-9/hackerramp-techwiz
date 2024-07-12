class Recommendation {
  final int id;
  final String image;
  final String item;
  final num price;
  final String brand;

  Recommendation({required this.id, required this.image, required this.item, required this.price, required this.brand});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      id: json['id'],
      image: json['image'],
      item: json['item'],
      price: json['price'],
      brand: json['brand'],
    );
  }
}