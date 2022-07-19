import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DbHelper.dart';
import 'Doctor_details_page.dart';
import 'Models/Trainer.dart';

class CategoryTrainer extends StatefulWidget {
  final List<Trainer> trainers;
  final int selectedCategory;

  const CategoryTrainer(
      {Key? key, required this.trainers, required this.selectedCategory})
      : super(key: key);

  @override
  State<CategoryTrainer> createState() => _CategoryTrainerState();
}

class _CategoryTrainerState extends State<CategoryTrainer> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context, widget.trainers, widget.selectedCategory);
  }

  Widget initWidget(
      BuildContext context, List<Trainer> trainers, int selectedCategory) {
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
              child: ListView.builder(
                  itemCount: trainers.length,
                  itemBuilder: (BuildContext context, int index) {
                    for (int i = 0;
                        i < trainers[index].category_id.length;
                        i++) {
                      if (selectedCategory == trainers[index].category_id[i]) {
                        return demoTopRatedDr(context, trainers[index]);
                      }
                    }
                    return SizedBox(
                      width: 0,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget demoTopRatedDr(BuildContext context, Trainer trainer) {
  Size size = MediaQuery.of(context).size;
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
