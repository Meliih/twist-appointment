import 'package:flutter/material.dart';

import '../Models/Auth.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUp();
}

bool isHidden = false;

class _SignUp extends State<SignUp> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double getSmallDiameter(BuildContext context) =>
        MediaQuery.of(context).size.width * 2 / 3;
    double getBiglDiameter(BuildContext context) =>
        MediaQuery.of(context).size.width * 7 / 8;

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.purple),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: const Center(
                child: Text(
                  "Twist",
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.purple),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(19)),
                  margin: const EdgeInsets.fromLTRB(20, 230, 20, 10),
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.purple,
                            ),
                            labelText: "Ad",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      Container(
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _surnameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.purple,
                            ),
                            labelText: "Soyad",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      Container(
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.mail_outline,
                              color: Colors.purple,
                            ),
                            labelText: "Email",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      Container(
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: isHidden,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.purple,
                            ),
                            suffixIcon: IconButton(
                              icon: isHidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: togglePasswordVisibilty,
                            ),
                            labelText: "Şifre",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      Container(
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: isHidden,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.purple,
                            ),
                            suffixIcon: IconButton(
                              icon: isHidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: togglePasswordVisibilty,
                            ),
                            labelText: "Şifrenizi Yeniden Giriniz",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () async {
                                setState(() {});
                                if (!isEmpty() && validator()) {
                                  if (await Auth().signup(
                                      _nameController.text,
                                      _surnameController.text,
                                      _passwordController.text,
                                      _emailController.text)) {
                                    Navigator.pop(context);
                                  } else {
                                    showAlert(
                                        "Bu kullanıcı adı zaten kullanılıyor.");
                                  }
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Kayıt Ol",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool isEmpty() {
    if (_nameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      showAlert("Boş alan bırakmayınız.");
      return true;
    }
    return false;
  }

  bool validator() {
    //username validation
    String nums = "0123456789";
    String username = _nameController.text + " " + _surnameController.text;

    for (int i = 0; i < username.length; i++) {
      bool correct = true;
      for (int j = 0; j < nums.length; j++) {
        if (username[i] == nums[j]) {
          correct = false;
        }
      }
      if (!correct) {
        showAlert("Kullanıcı adınız yalnızca sayılardan oluşabilir");
        return false;
      }
    }
    // password validation
    if (_passwordController.text.length < 8) {
      showAlert("Parolanız en az 8 karakter olmalıdır.");
      return false;
    }

    // password confirmation validation
    if (_passwordController.text != _confirmPasswordController.text) {
      showAlert("Parolanız eşleşmiyor.");
      return false;
    }

    // email validation
    bool includeat = false;
    bool includeDot = false;
    for (int i = 0; i < _emailController.text.length; i++) {
      if (_emailController.text[i] == '@') {
        includeat = true;
      } else if (_emailController.text[i] == '.') {
        includeDot = true;
      }
    }
    if (!includeat || !includeDot) {
      showAlert("Email adresinizi doğru girdiğinizden emin olunuz.");
      return false;
    }

    return true;
  }

  void showAlert(String alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hata"),
          content: Text(alert),
          actions: [
            FlatButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void togglePasswordVisibilty() => setState(() => isHidden = !isHidden);
}
