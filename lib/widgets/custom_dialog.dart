import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class CustomDialog extends StatefulWidget {
  String playerName;

  CustomDialog(this.playerName);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool isPlaying = true;
  final controller = ConfettiController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    controller.play();
    controller.addListener(() {
      setState(() {
        isPlaying = controller.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ConfettiWidget(
          //blastDirection: pi / 2,
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: controller,
          shouldLoop: true,
          emissionFrequency: 0.1,
          gravity: 0.1,
        ),
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.playerName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'WIN!',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: IconButton(
                    iconSize: 40,
                    color: Colors.green,
                    onPressed: () {
                      controller.stop();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.play_arrow_rounded),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.56,
          left: MediaQuery.of(context).size.width * 0.40,
          child: CircleAvatar(
            backgroundColor: Color.fromRGBO(
              Random().nextInt(256),
              Random().nextInt(256),
              Random().nextInt(256),
              1,
            ),
            radius: 40,
            child: Icon(
              Icons.military_tech,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
