import 'package:firebase_database/firebase_database.dart';

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

  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    final event = await FirebaseDatabase.instance.ref('Category').once();

    final data = event.snapshot.children;

    Category category;
    // child name
    data.forEach((element) {
      // add to list
      String name = element.child("name").value.toString();
      String img = element.child("img").value.toString();
      int trainerCount = element.child("trainerCount").value as int;
      int id = element.child("id").value as int;

      category = Category(id, img, name, trainerCount);
      //print(isActive);
      categories.add(category);
      //print(value);
    });
    return categories;
  }
}
