import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twist/HomePage.dart';
import 'package:twist/Models/Globals.dart' as globals;

import 'Screen/UserPageScreen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = globals.username;
    final email = globals.email;
    final image = globals.img;
    return Drawer(
      child: Material(
          color: Colors.purple,
          child: ListView(
            children: <Widget>[
              buildHeader(
                image: image,
                name: name,
                email: email,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserPage(),
                )),
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Abonelik",
                      icon: Icons.subscriptions,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Favoriler",
                      icon: Icons.favorite_border,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Bildirimler",
                      icon: Icons.notifications_outlined,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Güncellemeler",
                      icon: Icons.update,
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 20),
                    buildMenuItem(
                      text: "Destek",
                      icon: Icons.support,
                    ),
                    const SizedBox(height: 20),
                    buildMenuItem(
                        text: "Çıkış Yap",
                        icon: Icons.logout,
                        onClicked: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.remove('username');
                          prefs.remove('email');
                          setState(() {});
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        }),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(image),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
