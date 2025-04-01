// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables
import 'package:flappy_bird/Layouts/Widgets/widget_bird.dart';
import 'package:flappy_bird/Resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../Global/constant.dart';
import '../../Global/functions.dart';
import '../Widgets/widget_gradient _button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final myBox = Hive.box('user');

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          decoration: background(Str.image),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.40),
              myText("Flappy Bird", Colors.white, 50),
              SizedBox(height: 100),
              Bird(yAxis, birdWidth, birdHeight),
              SizedBox(height: 60),
              _buttons(),
              SizedBox(height: 100),
              AboutUs(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

// Three buttons
Column _buttons() {
  return Column(
    children: [
      Button(
        buttonType: "text",
        height: 60,
        width: 278,
        icon: Icon(Icons.play_arrow_rounded, size: 60, color: Colors.green),
        page: Str.gamePage,
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Button(
            buttonType: "icon",
            height: 60,
            width: 110,
            icon: Icon(Icons.settings, size: 40, color: Colors.grey.shade900),
            page: Str.settings,
          ),
          Button(
            buttonType: "icon",
            height: 60,
            width: 110,
            icon: Icon(Icons.star, size: 40, color: Colors.deepOrange),
            page: Str.rateUs,
          ),
        ],
      ),
    ],
  );
}

class AboutUs extends StatelessWidget {
  final Size size;
  AboutUs({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return dialog(context);
            },
          );
        },
        child: myText("About Us", Colors.white, 20),
      ),
    );
  }
}