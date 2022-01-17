import 'package:tetris/hit_edge.dart';
import 'package:tetris/pick_block.dart';
import 'package:collection/collection.dart';

class TetrisFunction {
  Function eq = const ListEquality().equals;
  HitEdge hitEdge = HitEdge();
  PickBlock pickBlock = PickBlock();
  var str = List.filled(160, "", growable: false);
  var currentPiece = List.filled(4, 0, growable: false);

  assignCurrentPiece() {
    str = removeCompleteLine();
    currentPiece = pickBlock.pickElement();
    str = _setCurrentPiece();
    return str;
  }

  removeCompleteLine() {
    for (var j = 0; j < str.length - 10; j = j + 10) {
      var jRow = str.sublist(j, j + 10);
      if (jRow.every((e) => e == "x")) {
        for (var i = j + 9; i > 9; i--) {
          str[i] = str[i - 10];
        }
        for (var i = 0; i < 10; i++) {
          str[i] = "";
        }
      }
    }
    return str;
  }

  moveCurrentPiece(direction) {
    if (hitEdge.hitBase(currentPiece, str)) {
      str = assignCurrentPiece();
    } else {
      str = _removeLastCurrentPiece();
      if (direction == "down" && !hitEdge.hitBase(currentPiece, str)) {
        str = _moveDownCurrentPiece();
      } else if (direction == "left" &&
          !hitEdge.hitSideLeft(currentPiece, str)) {
        str = _moveLeftCurrentPiece();
      } else if (direction == "right" &&
          !hitEdge.hitSideRight(currentPiece, str)) {
        str = _moveRightCurrentPiece();
      } else if (direction == "turn" &&
          !hitEdge.hitSideRight(currentPiece, str) &&
          !hitEdge.hitSideLeft(currentPiece, str) &&
          !hitEdge.hitBase(currentPiece, str)) {
        str = _turnCurrentPiece(currentPiece[0]);
      }
      str = _setCurrentPiece();
    }
    return str;
  }

  _setCurrentPiece() {
    currentPiece.map((e) {
      if (str[e] == '') str[e] = "x";
    }).toList();
    return str;
  }

  _removeLastCurrentPiece() {
    var lastCurrentPiece = currentPiece;
    lastCurrentPiece.map((e) {
      if (str[e] == 'x') str[e] = "";
    }).toList();
    return str;
  }

  _moveRightCurrentPiece() {
    final List<int> current = [];
    currentPiece.map((e) => current.add(e + 1)).toList();
    currentPiece = current;
    return str;
  }

  _moveDownCurrentPiece() {
    final List<int> current = [];
    currentPiece.map((e) => current.add(e + 10)).toList();
    currentPiece = current;
    return str;
  }

  _moveLeftCurrentPiece() {
    final List<int> current = [];
    currentPiece.map((e) => current.add(e - 1)).toList();
    currentPiece = current;
    return str;
  }

  _turnCurrentPiece(x) {
    if (eq(currentPiece, [x, x + 1, x + 2, x + 3])) {
      currentPiece = [x, x + 10, x + 20, x + 30];
    } else if (eq(currentPiece, [x, x + 10, x + 20, x + 30])) {
      currentPiece = [x, x + 1, x + 2, x + 3];
    } else if (eq(currentPiece, [x, x + 1, x + 9, x + 10])) {
      currentPiece = [x, x + 10, x + 11, x + 21];
    } else if (eq(currentPiece, [x, x + 10, x + 11, x + 21])) {
      currentPiece = [x, x + 1, x + 9, x + 10];
    } else if (eq(currentPiece, [x, x + 1, x + 11, x + 12])) {
      currentPiece = [x, x + 9, x + 10, x + 19];
    } else if (eq(currentPiece, [x, x + 9, x + 10, x + 19])) {
      currentPiece = [x, x + 1, x + 11, x + 12];
    } else if (eq(currentPiece, [x, x + 9, x + 10, x + 20])) {
      currentPiece = [x, x + 9, x + 10, x + 11];
    } else if (eq(currentPiece, [x, x + 9, x + 10, x + 11])) {
      currentPiece = [x, x + 10, x + 11, x + 20];
    } else if (eq(currentPiece, [x, x + 10, x + 11, x + 20])) {
      currentPiece = [x, x + 1, x + 2, x + 11];
    } else if (eq(currentPiece, [x, x + 1, x + 2, x + 11])) {
      currentPiece = [x, x + 9, x + 10, x + 20];
    } else if (eq(currentPiece, [x, x + 1, x + 10, x + 20])) {
      currentPiece = [x, x + 1, x + 2, x + 12];
    } else if (eq(currentPiece, [x, x + 1, x + 2, x + 12])) {
      currentPiece = [x, x + 10, x + 19, x + 20];
    } else if (eq(currentPiece, [x, x + 10, x + 19, x + 20])) {
      currentPiece = [x, x + 10, x + 11, x + 12];
    } else if (eq(currentPiece, [x, x + 10, x + 11, x + 12])) {
      currentPiece = [x, x + 1, x + 10, x + 20];
    } else if (eq(currentPiece, [x, x + 1, x + 11, x + 21])) {
      currentPiece = [x, x + 8, x + 9, x + 10];
    } else if (eq(currentPiece, [x, x + 8, x + 9, x + 10])) {
      currentPiece = [x, x + 10, x + 20, x + 21];
    } else if (eq(currentPiece, [x, x + 10, x + 20, x + 21])) {
      currentPiece = [x, x + 1, x + 2, x + 10];
    } else if (eq(currentPiece, [x, x + 1, x + 2, x + 10])) {
      currentPiece = [x, x + 1, x + 11, x + 21];
    }
    return str;
  }
}
