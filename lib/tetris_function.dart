import 'package:tetris/hit_edge.dart';
import 'package:tetris/pick_block.dart';

class TetrisFunction {
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
}
