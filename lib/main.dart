import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:kana_kanji_app/characterView.dart';

void main() {
  runApp(const KanjiApp());
}

class KanjiApp extends StatefulWidget {
  const KanjiApp({Key? key}) : super(key: key);

  @override
  State<KanjiApp> createState() => _KanjiAppState();
}

class _KanjiAppState extends State<KanjiApp> {
  var images = getImages();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(),
        body: FutureBuilder(
          future: images,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: (snapshot.data as List).length,
                itemBuilder: (context, int index) {
                  final charPath = (snapshot.data as List<String>)[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CharacterView(charPath: charPath,);
                            },
                          ),
                        );
                      },
                      onLongPress: () {
                        print(charPath);
                      },
                      child: Container(
                        color: Colors.white70,
                        width: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AnimatedDrawing.svg(
                            charPath,
                            run: true,
                            duration: new Duration(milliseconds: 0),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Future<List<String>> getImages() async {
  // >> To get paths you need these 2 lines
  final manifestContent = await rootBundle.loadString('AssetManifest.json');

  final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  // >> To get paths you need these 2 lines

  final imagePaths = manifestMap.keys
      .where((String key) => key.contains('.svg'))
      .where(
        (String key) => !key.contains(
          RegExp(r"(000[0-9])|(0ff[0-9])"),
        ),
      )
      .toList();

  return imagePaths;
}
