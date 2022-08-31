import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../functions/borderFunction.dart';
import '../functions/checkIfWin.dart';
import '../widgets/custom_dialog.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

    Future<void> openDialog(int winner) async {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return CustomDialog("Gracz X");
          }).then((value) {
        setState(() {
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
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: fileds.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          if (winner != 0) {
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
                            ? Center(
                                child:
                                    Text('x', style: TextStyle(fontSize: 40)),
                              )
                            : fileds[index] == 2
                                ? Center(
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
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
