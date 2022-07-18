import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twist/Models/Globals.dart' as globals;
import 'package:twist/Models/User.dart';

class Auth {
  //read data null check
  Future<bool> login(String email, String password, bool unforget) async {
    final event = await FirebaseDatabase.instance
        .ref('users/${email.replaceAll(".", "")}')
        .once();

    if (event.snapshot.value == null)
      return false;
    else {
      final passwordInput = event.snapshot.child('password').value.toString();
      final emailInput = event.snapshot.child('email').value.toString();
      final nameInput = event.snapshot.child('name').value.toString();
      final surnameInput = event.snapshot.child('surname').value.toString();

      if (emailInput == email &&
          passwordInput == base64Encode(utf8.encode(password))) {
        if (unforget) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', nameInput + " " + surnameInput);
          prefs.setString('email', emailInput);
        }

        globals.username = nameInput + " " + surnameInput;
        globals.email = emailInput;
        return true;
      } else
        return false;
    }
  }

  Future<bool> signup(
      String name, String surname, String password, String email) async {
    bool log = await login(email, password, false);
    // encode password
    password = base64Encode(utf8.encode(password));

    //decode password

    if (log == true)
      return false;
    else {
      User user = User(0, name, surname, "image/woman.png", password, email,
          name + " " + surname);
      ;
      DatabaseReference reference = FirebaseDatabase.instance
          .reference()
          .child("users/${email.replaceAll(".", "")}");
      reference.set(user.toMap());
      return true;
    }
  }
}
