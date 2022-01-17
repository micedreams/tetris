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
  var lines = 0;

  @override
  void initState() {
    var data = function.assignCurrentPiece();
    setState(() {
      str = data[0];
      lines = data[1];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("tetris"),
        ),
        body: InkWell(
          onLongPress: () {
            var data = function.reset();
            setState(() {
              str = data[0];
              lines = data[1];
            });
            data = function.assignCurrentPiece();
            setState(() {
              str = data[0];
              lines = data[1];
            });
          },
          child: Column(
            children: [
              FutureBuilder(future: (() async {
                await Future<void>.delayed(const Duration(seconds: 1));
                if (function.hitBase(str)) {
                  var data = function.assignCurrentPiece();
                  setState(() {
                    str = data[0];
                    lines = data[1];
                  });
                } else {
                  await Future<void>.delayed(const Duration(seconds: 10));
                  setState(() {
                    str = function.moveCurrentPiece("down");
                  });
                }
              })(), builder: (context, snapshot) {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 10,
                  children: List.generate(str.length, (index) {
                    return GridTile(
                      child: str[index] != ""
                          ? const Card(color: Colors.black)
                          : const Card(color: Colors.grey),
                    );
                  }),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("lines: $lines"),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
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
          ),
        ));
  }
}
