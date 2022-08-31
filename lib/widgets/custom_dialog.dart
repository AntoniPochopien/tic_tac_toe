import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class CustomDialog extends StatefulWidget {
  String playerName;

  CustomDialog(this.playerName);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  bool isPlaying = true;
  final confettiController = ConfettiController();
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  Color bgColor = Color.fromRGBO(
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
    1,
  );

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut);

    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();

    confettiController.play();
    confettiController.addListener(() {
      setState(() {
        isPlaying = confettiController.state == ConfettiControllerState.playing;
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
          confettiController: confettiController,
          shouldLoop: true,
          emissionFrequency: 0.1,
          gravity: 0.1,
        ),
        ScaleTransition(
          scale: animationController,
          child: Dialog(
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
                        confettiController.stop();
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.play_arrow_rounded),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.56,
          left: MediaQuery.of(context).size.width * 0.40,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: CircleAvatar(
              backgroundColor: bgColor,
              radius: 40,
              child: Icon(
                Icons.military_tech,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
