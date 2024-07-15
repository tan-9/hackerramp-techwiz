import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = Random();
  int currentImageIndex = 0;
  int counter = 1;
  bool showAnimation = false;
  List<String> images = [
    'assets/images/dice_1.png',
    'assets/images/dice_2.png',
    'assets/images/dice_3.png',
    'assets/images/dice_4.png',
    'assets/images/dice_5.png',
    'assets/images/dice_6.png',
  ];
  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My daily rewards'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Center animation GIF when dice rolls a 6
          if (showAnimation)
            Center(
              child: Image.asset(
                'assets/images/dice_six_animation.gif',
                height: 200,
                width: 200,
              ),
            ),
          // Dice image at bottom center with tap detection
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: GestureDetector(
                onTap: () async {
                  // Rolling the dice
                  // Reset animation visibility
                  setState(() {
                    showAnimation = false;
                  });

                  // Sound
                  await player.setAsset('assets/audios/rolling-dice.mp3');
                  player.play();

                  // Roll the dice
                  Timer.periodic(const Duration(milliseconds: 80), (timer) {
                    counter++;
                    setState(() {
                      currentImageIndex = random.nextInt(6);
                    });

                    if (counter >= 13) {
                      timer.cancel();
                      if (currentImageIndex == 5) {
                        // Show animation if dice rolls a 6
                        setState(() {
                          showAnimation = true;
                        });
                      }
                      setState(() {
                        counter = 1;
                      });
                    }
                  });
                },
                child: Image.asset(
                  images[currentImageIndex],
                  height: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
