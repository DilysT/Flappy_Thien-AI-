// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flappy_bird/Layouts/Pages/page_start_screen.dart';
import 'package:flappy_bird/Layouts/Widgets/widget_bird_settings.dart';
import 'package:flappy_bird/Layouts/Widgets/widget_difficulty_settings.dart';
import 'package:flappy_bird/Layouts/Widgets/widget_music_settings.dart';
import 'package:flappy_bird/Layouts/Widgets/widget_themes_settings.dart';
import 'package:flappy_bird/Resources/strings.dart';
import 'package:flutter/material.dart';
import '../../Global/functions.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: background(Str.image),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.05, left: 8),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, size: 50, color: Colors.white),
                ),
              ),
            ),

            // Box chứa các setting
            Expanded(
              child: Container(

                width: size.width * 0.88,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(10),
                decoration: frame(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,  // Giúp tránh lỗi Overflow
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    myText("Setting", Colors.pinkAccent, 35),
                    SizedBox(height: 10),  // Tạo khoảng cách giữa các thành phần
                    BirdSettings(),
                    ThemesSettings(),
                    MusicSettings(),
                    DifficultySettings(),
                    SizedBox(height: 20),  // Giúp nút Apply không bị dính vào các widget khác
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StartScreen()),
                        );
                      },
                      child: myText("Apply", Colors.white, 35),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
