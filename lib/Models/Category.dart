class Category {
  late int id;
  late String img;
  late String name;
  late int trainerCount;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "img": img,
      "trainerCount": trainerCount,
    };
    return map;
  }

  Category.fromMap(Map<String, dynamic> jsonMap)
      : id = jsonMap["id"],
        name = jsonMap["name"],
        trainerCount = jsonMap["trainerCount"],
        img = jsonMap["img"];

  Category(this.id, this.img, this.name, this.trainerCount);
}
