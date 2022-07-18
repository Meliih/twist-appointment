class User {
  late int id;
  late String name;
  late String surname;
  late String img;
  late String password;
  late String email;
  late String userName;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "surname": surname,
      "img": img,
      "password": password,
      "email": email,
      "userName": userName
    };
    return map;
  }

  User(this.id, this.name, this.surname, this.img, this.password, this.email,
      this.userName);
}
