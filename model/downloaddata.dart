class DownloadData {
  String? id;
  String? name;
  String? url;
  String? image;
  String? price;
  DownloadData({
    this.id,
    this.image,
    this.name,
    this.price,
    this.url,
  });

  factory DownloadData.fromJson(Map<String, dynamic> parsedJson) {
    return new DownloadData(
      id: parsedJson['id'],
      name: parsedJson['name'],
      url: parsedJson['url'],
      image: parsedJson['image'],
      price: parsedJson['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "url": url,
      "image": image,
      "price": price,
    };
  }
}
