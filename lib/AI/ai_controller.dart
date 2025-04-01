import 'dart:async'; // Dùng cho Timer
import 'package:flutter/material.dart'; // Dùng cho VoidCallback

class BirdAI {
  final VoidCallback onJump;
  List<List<double>> barrierHeight;
  List<double> barrierX;
  double birdY;

  BirdAI({
    required this.onJump,
    required this.barrierHeight,
    required this.barrierX,
    required this.birdY,
  });

  void start() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      print("🔍 AI đang kiểm tra vật cản...");

      if (shouldJump()) {
        print("🚀 AI quyết định nhảy!");
        onJump();
      }
    });
  }

  bool shouldJump() {
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] < 0.2 && barrierX[i] > -0.2 && birdY > -0.5) {
        print("⚠️ AI phát hiện vật cản và sẽ nhảy!");
        return true;
      }
    }
    return false;
  }

}
