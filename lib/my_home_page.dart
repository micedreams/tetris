import 'package:flutter/material.dart';
import 'package:tetris/tetris_function.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TetrisFunction function = TetrisFunction();
  var str = List.filled(160, "", growable: false);
  var currentPiece = List.filled(4, 0, growable: false);
  var lastCurrentPiece = List.filled(4, 0, growable: false);
  @override
  void initState() {
    assignCurrentPiece();
    setCurrentPiece();
    super.initState();
  }

  void assignCurrentPiece() {
    setState(() {
      lastCurrentPiece = List.filled(4, 0, growable: false);
      currentPiece = function.pickElement();
    });
  }

  void setCurrentPiece() {
    for (var i = 0; i < currentPiece.length; i++) {
      if (str[currentPiece[i]] == '') {
        setState(() {
          str[currentPiece[i]] = "x";
        });
      }
    }
  }

  void removeLastCurrentPiece() {
    for (var i = 0; i < lastCurrentPiece.length; i++) {
      if (str[lastCurrentPiece[i]] == 'x') {
        setState(() {
          str[lastCurrentPiece[i]] = "";
        });
      }
    }
  }

  moveDownCurrentPiece() {
    if (!function.hitBase(currentPiece, str)) {
      for (var i = 0; i < currentPiece.length; i++) {
        setState(() {
          currentPiece[i] = currentPiece[i] + 10;
        });
      }
    }
  }

  moveRightCurrentPiece() {
    if (!function.hitSideRight(currentPiece, str)) {
      for (var i = 0; i < currentPiece.length; i++) {
        setState(() {
          currentPiece[i] = currentPiece[i] + 1;
        });
      }
    }
  }

  moveLeftCurrentPiece() {
    if (!function.hitSideLeft(currentPiece, str)) {
      for (var i = 0; i < currentPiece.length; i++) {
        setState(() {
          currentPiece[i] = currentPiece[i] - 1;
        });
      }
    }
  }

  moveCurrentPiece(direction) {
    if (!function.hitBase(currentPiece, str)) {
      setState(() {
        lastCurrentPiece = currentPiece;
      });
      removeLastCurrentPiece();
      if (direction == "down") {
        moveDownCurrentPiece();
      } else if (direction == "left") {
        moveLeftCurrentPiece();
      } else if (direction == "right") {
        moveRightCurrentPiece();
      } else if (direction == "turn") {
        moveDownCurrentPiece();
      }
      setCurrentPiece();
    } else {
      assignCurrentPiece();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tetris"),
      ),
      body: Center(
        child: ListView(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 10,
              children: List.generate(160, (index) {
                return GridTile(
                  child: str[index] != ""
                      ? const Card(color: Colors.black)
                      : const Card(color: Colors.white),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    moveCurrentPiece("left");
                  },
                  child: const Text("<"),
                ),
                ElevatedButton(
                  onPressed: () {
                    moveCurrentPiece("down");
                  },
                  child: const Text("v"),
                ),
                ElevatedButton(
                  onPressed: () {
                    moveCurrentPiece("right");
                  },
                  child: const Text(">"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
