import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:drawing_animation/drawing_animation.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({Key? key, required this.charPath}) : super(key: key);

  final String charPath;

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {
  var run = true;
  var speed = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[700]),
      backgroundColor: Colors.lightBlue,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              widget.charPath,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
              ),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedDrawing.svg(
                      widget.charPath,
                      run: run,
                      duration: Duration(
                        milliseconds: (10000 / speed).round(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            iconSize: 50,
            onPressed: () {
              setState(() {
                run = !run;
              });
            },
            icon: Icon(
              run ? Icons.pause : Icons.play_arrow,
            ),
          ),
          Text(
            "Speed: ${(speed * 10).round()}",
            textScaleFactor: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Slider(
              thumbColor: Colors.lightGreen,
              activeColor: Colors.lightGreen[400],
              inactiveColor: Colors.lightGreen[100],
              value: speed,
              max: 8.0,
              min: 2.0,
              onChangeStart: (_) {
                setState(() {
                  run = false;
                });
              },
              onChangeEnd: (_) {
                setState(() {
                  run = true;
                });
              },
              onChanged: (newSpeed) {
                setState(() {
                  speed = newSpeed;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
