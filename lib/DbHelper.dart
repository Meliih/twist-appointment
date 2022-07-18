import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:twist/Models/Category.dart';
import 'package:twist/Models/Trainer.dart';

class DbHelper {
  void writeData(var trainer, String name) {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("Trainers/${name}");
    reference.set(trainer);
  }

  List<Trainer> Trainers() {
    Trainer trainer =
        Trainer(1, "image/woman.png", "Çağla Öner", "5.0", "", [1, 2]);
    Trainer trainer2 = Trainer(2, "image/girl.png", "Zeliha ", "5.0", "", [1]);
    Trainer trainer3 = Trainer(3, "image/woman.png", "Kadriye", "5.0", "", [1]);
    Trainer trainer4 = Trainer(4, "image/woman.png", "Mine", "5.0", "", [1]);
    Trainer trainer5 =
        Trainer(5, "image/woman.png", "Sibel", "5.0", "", [2, 1]);
    /*
    writeData(trainer.toMap(), trainer.name);
    writeData(trainer2.toMap(), trainer2.name);
    writeData(trainer3.toMap(), trainer3.name);
    writeData(trainer4.toMap(), trainer4.name);
    writeData(trainer5.toMap(), trainer5.name);
*/
    //readData();
    List<Trainer> trainers = List<Trainer>.filled(5, trainer);
    trainers[0] = trainer;
    trainers[1] = trainer2;
    trainers[2] = trainer3;
    trainers[3] = trainer4;
    trainers[4] = trainer5;

    return trainers;
  }

  List<Category> Categories() {
    Category category = Category(1, "image/2320765.png", "Pilates", 0);
    Category category1 =
        Category(2, "image/gymnastics.png", "Hamile Pilates", 0);
    List<Category> categories = List<Category>.filled(2, category);
    //writeData(category1.toMap(), category1.name);
    categories[0] = category;
    categories[1] = category1;

    return categories;
  }
}

Future<bool> signup(String username, String password, String email) async {
  // bool log = await login(username, password, false);
  // encode password
  // password = base64Encode(utf8.encode(password));

  //decode password

  /* if(log == true)
        return false;
      else*/
  {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("users");
    reference.set({'username': username, 'password': password, 'email': email});
    return true;
  }
}
