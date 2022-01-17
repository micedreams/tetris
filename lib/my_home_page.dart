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

  @override
  void initState() {
    setState(() {
      str = function.assignCurrentPiece();
    });
    super.initState();
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      str = function.moveCurrentPiece("left");
                    });
                  },
                  child: const Text("<"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      str = function.moveCurrentPiece("down");
                    });
                  },
                  child: const Text("v"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      str = function.moveCurrentPiece("right");
                    });
                  },
                  child: const Text(">"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      str = function.moveCurrentPiece("turn");
                    });
                  },
                  child: const Text("Turn"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
