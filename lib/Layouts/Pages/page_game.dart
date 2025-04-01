// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, avoid_print
import 'dart:async';
import 'package:flappy_bird/Layouts/Pages/page_start_screen.dart';
import 'package:flappy_bird/Layouts/Widgets/widget_bird.dart';
import 'package:flappy_bird/Layouts/Widgets/widget_barrier.dart';
import 'package:flappy_bird/Layouts/Widgets/widget_cover.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Database/database.dart';
import '../../Global/constant.dart';
import '../../Global/functions.dart';
import '../../Resources/strings.dart';
import '../../AI/ai_controller.dart';

class GamePage extends StatefulWidget {
  GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late BirdAI birdAI; // AI để điều khiển bird

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: background(Str.image),
                child: Stack(
                  children: [
                    Bird(yAxis, birdWidth, birdHeight),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: myText(gameHasStarted ? '' : 'TAP TO START', Colors.white, 25),
                    ),
                    Barrier(barrierHeight[0][0], barrierWidth, barrierX[0], true),
                    Barrier(barrierHeight[0][1], barrierWidth, barrierX[0], false),
                    Barrier(barrierHeight[1][0], barrierWidth, barrierX[1], true),
                    Barrier(barrierHeight[1][1], barrierWidth, barrierX[1], false),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      left: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Score : $score", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "Magic4")),
                            Text("Best : $topScore", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "Magic4")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Cover(),
            ),
          ],
        ),
      ),
    );
  }

  // Jump Function:
  void jump() {
    setState(() {
      time = 0;
      initialHeight = yAxis;
    });
  }

  // Start Game Function:
  void startGame() {
    gameHasStarted = true;

    // Khởi động AI khi game bắt đầu
    if (Str.bird == "assets/pics/avatar.jpg") {
      print("✅ AI đã được khởi động!");
      birdAI = BirdAI(
        onJump: () {
          print("🐦 AI đã nhảy!");
          jump();
        },
        barrierHeight: barrierHeight,
        barrierX: barrierX,
        birdY: yAxis,
      );
      birdAI.start();
    } else {
      print("🚫 AI không được kích hoạt vì avatar sai!");
    }


    Timer.periodic(Duration(milliseconds: 35), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        yAxis = initialHeight - height;
      });

      // Cập nhật vị trí vật cản
      for (int i = 0; i < barrierX.length; i++) {
        setState(() {
          if (barrierX[i] < screenEnd) {
            barrierX[i] += screenStart;
          } else {
            barrierX[i] -= barrierMovement;
          }
        });
      }

      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }
      time += 0.024;
    });

    // Tính điểm
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (birdIsDead()) {
        write("score", topScore);
        timer.cancel();
        score = 0;
      } else {
        setState(() {
          if (score == topScore) {
            topScore++;
          }
          score++;
        });
      }
    });
  }

  /// Kiểm tra bird có va vào vật cản hoặc màn hình không
  bool birdIsDead() {
    if (yAxis > 1.26 || yAxis < -1.1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          (barrierX[i] + (barrierWidth)) >= birdWidth &&
          (yAxis <= -1 + barrierHeight[i][0] ||
              yAxis + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      yAxis = 0;
      gameHasStarted = false;
      time = 0;
      score = 0;
      initialHeight = yAxis;
      barrierX[0] = 2;
      barrierX[1] = 3.4;
    });
  }

  // Hiển thị hộp thoại khi thua
  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: myText("..Oops", Colors.blue[900], 35),
          actionsPadding: EdgeInsets.only(right: 8, bottom: 8),
          content: Container(
            child: Lottie.asset("assets/pics/loss.json", fit: BoxFit.cover),
          ),
          actions: [
            gameButton(() {
              resetGame();
              Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreen()));
            }, "Exit", Colors.grey),
            gameButton(() {
              resetGame();
            }, "Try Again", Colors.green),
          ],
        );
      },
    );
  }
}
