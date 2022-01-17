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
    //str = completeLine();
    currentPiece = pickBlock.pickElement();
    str = _setCurrentPiece();
    return str;
  }

/*   completeLine() {
    for (var j = 0; j < 150; j = j + 10) {
      var jRow = str.sublist(j, j + 10);
      print(jRow.every((e) => e == "x"));

      if (jRow.every((e) => e == "x")) {
        for (var i = j + 10; i > 10; i--) {
          str[i] = str[i - 10];
        }
      }
    }

    return str;
  } */

  moveCurrentPiece(direction) {
    if (hitEdge.hitBase(currentPiece, str)) {
      str = assignCurrentPiece();
    } else {
      if (direction == "down") {
        str = _moveDownCurrentPiece();
      } else if (direction == "left") {
        str = _moveLeftCurrentPiece();
      } else if (direction == "right") {
        str = _moveRightCurrentPiece();
      } else if (direction == "turn") {
        str = _turnCurrentPiece();
      }
    }

    return str;
  }

  _setCurrentPiece() {
    for (var i = 0; i < currentPiece.length; i++) {
      if (str[currentPiece[i]] == '') {
        str[currentPiece[i]] = "x";
      }
    }
    return str;
  }

  _removeLastCurrentPiece() {
    var lastCurrentPiece = currentPiece;
    for (var i = 0; i < lastCurrentPiece.length; i++) {
      if (str[lastCurrentPiece[i]] == 'x') {
        str[lastCurrentPiece[i]] = "";
      }
    }
    return str;
  }

  _moveRightCurrentPiece() {
    str = _removeLastCurrentPiece();
    if (!hitEdge.hitSideRight(currentPiece, str)) {
      for (var i = 0; i < currentPiece.length; i++) {
        currentPiece[i] = currentPiece[i] + 1;
      }
    }
    str = _setCurrentPiece();
    return str;
  }

  _moveDownCurrentPiece() {
    str = _removeLastCurrentPiece();
    if (!hitEdge.hitBase(currentPiece, str)) {
      for (var i = 0; i < currentPiece.length; i++) {
        currentPiece[i] = currentPiece[i] + 10;
      }
    }
    str = _setCurrentPiece();
    return str;
  }

  _moveLeftCurrentPiece() {
    str = _removeLastCurrentPiece();
    if (!hitEdge.hitSideLeft(currentPiece, str)) {
      for (var i = 0; i < currentPiece.length; i++) {
        currentPiece[i] = currentPiece[i] - 1;
      }
    }
    str = _setCurrentPiece();
    return str;
  }

  _turnCurrentPiece() {
    var x = currentPiece[0];
    str = _removeLastCurrentPiece();
    if (!hitEdge.hitSideRight(currentPiece, str) &&
        !hitEdge.hitSideLeft(currentPiece, str) &&
        !hitEdge.hitBase(currentPiece, str)) {
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
    }
    str = _setCurrentPiece();
    return str;
  }
}
