import 'package:firebase_database/firebase_database.dart';

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
        category_id = jsonMap["categor_id"];

  Trainer(
      this.id, this.img, this.name, this.rating, this.domain, this.category_id);

  Future<List<Trainer>> getTrainers() async {
    List<Trainer> trainers = [];
    final event = await FirebaseDatabase.instance.ref('Trainers').once();

    final data = event.snapshot.children;

    Trainer trainer;
    // child name
    data.forEach((element) {
      // element keys

      int id = element.child("id").value as int;
      String img = element.child("img").value.toString();
      String name = element.child("name").value.toString();
      String rating = element.child("rating").value.toString();
      String domain = element.child("domain").value.toString();
      List<int> category_id = [];
      List<String> cate = element
          .child("categor_id")
          .value
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', '')
          .split(',');
      for (var i = 0; i < cate.length; i++) {
        category_id.add(int.parse(cate[i]));
        //print(category_id[i]);
      }
      //print(cate.length);

      trainer = Trainer(id, img, name, rating, domain, category_id);
      //print(isActive);
      trainers.add(trainer);
      //print(value);
    });
    return trainers;
  }
}
