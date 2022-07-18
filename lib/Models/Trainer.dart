class Trainer {
  late int id;
  late String img;
  late String name;
  late String rating;
  late String domain;
  late List<int> category_id;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "img": img,
      "rating": rating,
      "domain": domain,
      "categor_id": category_id
    };
    return map;
  }

  Trainer.fromMap(Map<String, dynamic> jsonMap)
      : id = jsonMap["id"],
        name = jsonMap["name"],
        rating = jsonMap["rating"],
        domain = jsonMap["domain"],
        category_id = jsonMap["category_id"];

  Trainer(
      this.id, this.img, this.name, this.rating, this.domain, this.category_id);
}
