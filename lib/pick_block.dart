import "dart:math";

class PickBlock {
  final _random = Random();
  var blocks = [
    [4, 5, 6, 7],
    [4, 5, 6, 14],
    [4, 5, 6, 15],
    [4, 5, 13, 14],
    [4, 5, 14, 15],
    [4, 5, 15, 16]
  ];

  pickElement() {
    return blocks[_random.nextInt(blocks.length)];
  }
}
