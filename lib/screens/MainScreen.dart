import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../functions/borderFunction.dart';
import '../functions/checkIfWin.dart';
import '../widgets/custom_dialog.dart';

class MainScreen extends StatefulWidget {
  int finalScore;
  String p1Name;
  String p2Name;

  MainScreen(this.finalScore, this.p1Name, this.p2Name);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLastRound = false;
  int ScoreP1 = 0;
  int ScoreP2 = 0;
  List<int> fileds = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  bool turn = false;
  int winner = 0;
  Color bgColor = Color.fromRGBO(
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
    1,
  );

  @override
  Widget build(BuildContext context) {
    void refreshGame() {
      fileds = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ];
    }

    Future<void> openDialog(
      int winner,
    ) async {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return CustomDialog(
                turn ? widget.p1Name : widget.p2Name, winner, isLastRound);
          }).then((value) {
        setState(() {
          if (isLastRound) {
            Navigator.of(context).pop();
          }
          refreshGame();
        });
      });
    }

    return Scaffold(
      body: AnimatedContainer(
        decoration: BoxDecoration(color: bgColor),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '${widget.p1Name} : $ScoreP1',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '$ScoreP2 : ${widget.p2Name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ]),
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: fileds.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (fileds[index] != 0) {
                          return;
                        }
                        setState(() {
                          fileds[index] = turn == false ? 1 : 2;
                          winner = checkIfWin(fileds, turn == false ? 1 : 2);
                          if (winner == 1 || winner == 2) {
                            if (winner == 1) {
                              ScoreP1 += 1;
                            }
                            if (winner == 2) {
                              ScoreP2 += 1;
                            }
                            if (widget.finalScore == ScoreP1 ||
                                widget.finalScore == ScoreP2) {
                              isLastRound = true;
                              ScoreP1 = 0;
                              ScoreP2 = 0;
                              openDialog(winner);
                            } else {
                              openDialog(winner);
                            }
                          }
                          if (winner == 3) {
                            openDialog(winner);
                          }
                          turn = !turn;
                          bgColor = Color.fromRGBO(
                            Random().nextInt(256),
                            Random().nextInt(256),
                            Random().nextInt(256),
                            1,
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: determineBorder(index),
                        ),
                        child: fileds[index] == 1
                            ? const Center(
                                child:
                                    Text('x', style: TextStyle(fontSize: 40)),
                              )
                            : fileds[index] == 2
                                ? const Center(
                                    child: Text(
                                      'o',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  )
                                : null,
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: Text(
                    turn == false ? 'x' : 'o',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
