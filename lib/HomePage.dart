import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twist/CategoryTrainer.dart';
import 'package:twist/DbHelper.dart';
import 'package:twist/Models/AppointmentDate.dart';
import 'package:twist/NavigationDrawer.dart';
import 'package:twist/Screen/UserPageScreen.dart';
import 'Doctor_details_page.dart';
import 'Models/Category.dart';
import 'Models/Trainer.dart';
import 'Screen/NotificationScreen.dart';
import 'package:twist/Models/Globals.dart' as globals;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Future<List<Trainer>> trainers =
        Trainer(0, "", "", "", "", []).getTrainers();
    List<Category> categories = DbHelper().Categories();
/*
    for (int i = 0; i < categories.length; i++) {
      for (int j = 0; j < trainers.length; j++) {
        for (int k = 0; k < trainers[j].category_id.length; k++) {
          if (categories[i].id == trainers[j].category_id[k]) {
            categories[i].trainerCount++;
          }
        }
      }
    }
*/
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
        //centerTitle: true,
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                backgroundImage: new AssetImage("image/girl.png"),
                radius: 22.0,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserPage()));
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width - 40,
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Merhaba, ${globals.username}",
                style: GoogleFonts.poiretOne(
                  color: Color(0xff363636),
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              width: size.width - 40,
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                child: Text(
                  "Kategori",
                  style: GoogleFonts.poiretOne(
                    color: Color(0xff363636),
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return demoCategories(trainers, categories[index]);
                  }),
            ),
            Container(
              width: size.width - 40,
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                child: Text(
                  'Eğitmenler',
                  style: GoogleFonts.poiretOne(
                    color: Color(0xff363636),
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: FutureBuilder<List<Trainer>>(
                    future: trainers,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return demoTopRatedDr(
                                  context, snapshot.data![index]);
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget demoCategories(Future<List<Trainer>> trainers, Category category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryTrainer(
                    trainers: trainers, selectedCategory: category.id)));
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Color(0xff107163),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(category.img, height: 50),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                category.name,
                style: GoogleFonts.poiretOne(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Color(0xffd9fffa).withOpacity(0.07),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                category.trainerCount.toString(),
                style: GoogleFonts.poiretOne(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoTopRatedDr(BuildContext context, Trainer trainer) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetailPage(
                      trainer: trainer,
                    )));
      },
      child: Container(
        height: 90,
        width: size.width - 40,
        margin: EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 90,
              width: 50,
              child: Image.asset(trainer.img),
            ),
            Container(
              width: size.width - 140,
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      trainer.name,
                      style: GoogleFonts.poiretOne(
                        color: Color(0xff363636),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trainer.name,
                          style: GoogleFonts.poiretOne(
                            color: Color(0xff363636),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Puan: " + trainer.rating,
                          style: GoogleFonts.poiretOne(
                            color: Color(0xff363636),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
