import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bird/bird.dart';
import 'package:flutter_bird/barriers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double yaxis = 0;
  double height = 0;
  double initialHeight = yaxis;
  double time = 0;
  bool gameStarted = false;
  static double score = 0;
  double bestscore= 0;
  
  


  static double xone = 2.5;
  double xtwo = xone + 1.8;

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      yaxis = 0;
      gameStarted = false;
      time = 0;
      initialHeight = yaxis;
      xone = 2.5;
      xtwo = xone + 1.8;
      score = 0;
    });
  }

  void gameover() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                'G A M E   O V E R',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: Text(
              "SCORE: " + score.toString(),
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7.0),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      'P L A Y  A G A I N',
                      style: TextStyle(color: Colors.brown),
                    )),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void jump() {
    score++;
    bestscore = score;
    setState(() {
      time = 0;
      initialHeight = yaxis;
      
    });
  }

   

  void startGame() {
    gameStarted = true;
    
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = (-4.9 * time * time) + 2.8 * time;
      setState(() {
        
        yaxis = initialHeight - height;
      });

      setState(
        () {
          if (xone < -2) {
            xone += 3.5;
          } else {
            xone -= 0.05;
          }
        },
      );
      setState(
        () {
     
          if (xtwo < -2) {
            xtwo += 3.5;
          } else {
            xtwo -= 0.05;
            
          }
        },
      );

      if (yaxis < -1 || yaxis > 1) {
        timer.cancel();
        gameStarted = false;
        gameover();
      }

    });
  }

 


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
        
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, yaxis),
                    duration: Duration(milliseconds: 1),
                    color: Colors.blue,
                    child: Bird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameStarted
                        ? Text(' ')
                        : Text(
                            'T A P    T O    P L A Y',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xone, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xone, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xtwo, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(xtwo, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: 250.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20.0,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SCORE',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            score.toString(),
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      
                      Column(
                        
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BEST',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            bestscore.toString(),
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
