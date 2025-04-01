// ignore_for_file: prefer_const_constructors

import 'package:flappy_bird/Database/database.dart';
import 'package:flappy_bird/Resources/strings.dart';
import 'package:flutter/material.dart';

import '../../Global/constant.dart';
import '../../Global/functions.dart';

class BirdSettings extends StatelessWidget {
  const BirdSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: myText("Characters", Colors.black, 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Str.bird = "assets/pics/bird.png";
                write("bird", Str.bird);
              },
              child: SizedBox(
                width: 75,
                height: 75,
                child: Image.asset(
                  "assets/pics/bird.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Str.bird = "assets/pics/blue.png";
                write("bird", Str.bird);
              },
              child: SizedBox(
                width: 75,
                height: 75,
                child: Image.asset(
                  "assets/pics/blue.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Str.bird = "assets/pics/green.png";
                write("bird", Str.bird);
              },
              child: SizedBox(
                width: 75,
                height: 75,
                child: Image.asset(
                  "assets/pics/green.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Str.bird = "assets/pics/avatar.jpg"; // Thêm avatar của bạn
                write("bird", Str.bird);
              },
              child: SizedBox(
                width: 35,
                height: 35,
                child: Image.asset(
                  "assets/pics/avatar.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
