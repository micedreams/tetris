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
      body: ListView(
        children: [
          FutureBuilder(future: (() async {
            await Future<void>.delayed(Duration(seconds: 1));
            if (function.hitBase(str)) {
              str = function.assignCurrentPiece();
            } else {
              await Future<void>.delayed(Duration(seconds: 10));
              setState(() {
                str = function.moveCurrentPiece("down");
              });
            }
          })(), builder: (context, snapshot) {
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 10,
              children: List.generate(160, (index) {
                return GridTile(
                  child: str[index] != ""
                      ? const Card(color: Colors.black)
                      : const Card(color: Colors.white),
                );
              }),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["left", "turn", "right"].map((entry) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    str = function.moveCurrentPiece(entry);
                  });
                },
                child: Text(entry),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
