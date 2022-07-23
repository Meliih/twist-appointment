import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DbHelper.dart';
import 'Doctor_details_page.dart';
import 'Models/Category.dart';
import 'Models/Trainer.dart';

class CategoryTrainer extends StatefulWidget {
  final Future<List<Trainer>> trainers;
  final int selectedCategory;
  final Category category;

  const CategoryTrainer({
    Key? key,
    required this.trainers,
    required this.selectedCategory,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryTrainer> createState() => _CategoryTrainerState();
}

class _CategoryTrainerState extends State<CategoryTrainer> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context, widget.trainers, widget.selectedCategory);
  }

  Widget initWidget(BuildContext context, Future<List<Trainer>> trainers,
      int selectedCategory) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
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
                            for (int i = 0;
                                i < snapshot.data![index].category_id.length;
                                i++) {
                              if (selectedCategory ==
                                  snapshot.data![index].category_id[i]) {
                                return demoTopRatedDr(context,
                                    snapshot.data![index], widget.category);
                              }
                            }
                            return SizedBox(
                              width: 0,
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget demoTopRatedDr(
    BuildContext context, Trainer trainer, Category category) {
  Size size = MediaQuery.of(context).size;

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoctorDetailPage(
                    trainer: trainer,
                    category: category,
                  )));
    },
    child: Container(
      height: 115,
      width: size.width - 40,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: _buildRow(context, trainer),
    ),
  );
}

Widget _buildRow(BuildContext context, Trainer trainer) {
  return Container(
    padding: const EdgeInsets.all(15),
    child: Row(
      children: <Widget>[
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(trainer.img),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    trainer.name,
                    maxLines: 3,
                    style: GoogleFonts.poiretOne(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        trainer.rating,
                        style: GoogleFonts.poiretOne(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      Text("Puan",
                          style: GoogleFonts.poiretOne(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    ),
  );
}
