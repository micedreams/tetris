import 'package:collection/collection.dart';
import "dart:math";
import 'package:tetris/constants.dart';

class TetrisFunction {
  Function eq = const ListEquality().equals;
  final _random = Random();
  var str = List.filled(160, "", growable: false);
  var currentPiece = List.filled(4, 0, growable: false);
  var nextCurrentPiece = List.filled(4, 0, growable: false);
  var lines = 0;

  assignCurrentPiece() {
    var data = removeCompleteLine();
    str = data[0];
    lines = data[1];
    currentPiece = BLOCKS[_random.nextInt(BLOCKS.length)];
    str = _setCurrentPiece();
    return [str, lines];
  }

  reset() {
    str = List.filled(160, "", growable: false);
    currentPiece = List.filled(4, 0, growable: false);
    return [str, lines];
  }

  removeCompleteLine() {
    for (var j = 0; j < str.length - 10; j = j + 10) {
      var jRow = str.sublist(j, j + 10);
      if (jRow.every((e) => e == "x")) {
        lines = lines + 1;
        for (var i = j + 9; i > 9; i--) {
          str[i] = str[i - 10];
        }
        for (var i = 0; i < 10; i++) {
          str[i] = "";
        }
      }
    }
    return [str, lines];
  }

  moveCurrentPiece(direction) {
    str = _removeLastCurrentPiece();
    if (direction == "down" && !hitBase(str)) {
      str = _moveDownCurrentPiece();
    } else if (direction == "left" && !_hitSideLeft(str)) {
      str = _moveLeftCurrentPiece();
    } else if (direction == "right" && !_hitSideRight(str)) {
      str = _moveRightCurrentPiece();
    } else if (direction == "turn" &&
        !_hitSideRight(str) &&
        !_hitSideLeft(str) &&
        !hitBase(str)) {
      str = _turnCurrentPiece(currentPiece[0]);
    }
    str = _setCurrentPiece();

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

  hitBase(str) {
    for (var i = 0; i < currentPiece.length; i++) {
      nextCurrentPiece[i] = currentPiece[i] + 10;
    }
    for (var i = 0; i < nextCurrentPiece.length; i++) {
      if (nextCurrentPiece[i] > 159) {
        return true;
      }
    }
    var x = nextCurrentPiece[0];

    if (eq(nextCurrentPiece, [x, x + 1, x + 2, x + 3]) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 9, x + 10]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 8, x + 9, x + 10]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 2, x + 10])) &&
        (str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 11, x + 12]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 2, x + 11])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 2, x + 12])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 10, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 19]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 11, x + 20]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 20, x + 21]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 19, x + 20])) &&
        (str[nextCurrentPiece[2]] == 'x' || str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 10, x + 20]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 20]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 11, x + 12]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 11, x + 21])) &&
        (str[nextCurrentPiece[1]] == 'x' || str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 11, x + 21])) &&
        (str[nextCurrentPiece[0]] == 'x' || str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 10, x + 20, x + 30])) &&
        (str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    return false;
  }

  _hitSideLeft(str) {
    for (var i = 0; i < currentPiece.length; i++) {
      if (currentPiece[i] < 0) {
        return true;
      }
    }

    for (var i = 0; i < currentPiece.length; i++) {
      nextCurrentPiece[i] = currentPiece[i] - 1;
    }
    for (var i = 0; i < nextCurrentPiece.length; i++) {
      if (LEFT_EDGE.contains(currentPiece[i])) {
        return true;
      }
    }

    var x = nextCurrentPiece[0];
    if ((eq(nextCurrentPiece, [x, x + 10, x + 20, x + 30])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 10, x + 11, x + 21]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 19]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 11, x + 20]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 20])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 10, x + 20, x + 21]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 19, x + 20])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x')) {
      return true;
    }

    if ((eq(nextCurrentPiece, [x, x + 1, x + 11, x + 21]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 10, x + 20])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 2, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 2, x + 10]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 2, x + 12])) &&
        (str[nextCurrentPiece[0]] == 'x' || str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 10, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 9, x + 10]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 11, x + 12])) &&
        (str[nextCurrentPiece[0]] == 'x' || str[nextCurrentPiece[2]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 9, x + 10, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 8, x + 9, x + 10]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 11, x + 12])) &&
        (str[nextCurrentPiece[0]] == 'x' || str[nextCurrentPiece[1]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 2, x + 3])) &&
        (str[nextCurrentPiece[0]] == 'x')) {
      return true;
    }

    return false;
  }

  _hitSideRight(str) {
    for (var i = 0; i < currentPiece.length; i++) {
      if (currentPiece[i] > 159) {
        return true;
      }
    }

    for (var i = 0; i < currentPiece.length; i++) {
      nextCurrentPiece[i] = currentPiece[i] + 1;
    }
    for (var i = 0; i < nextCurrentPiece.length; i++) {
      if (RIGHT_EDGE.contains(currentPiece[i])) {
        return true;
      }
    }

    var x = nextCurrentPiece[0];
    if ((eq(nextCurrentPiece, [x, x + 10, x + 20, x + 30])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 10, x + 11, x + 21]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 19]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 11, x + 20]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 20])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 10, x + 20, x + 21]) ||
            eq(nextCurrentPiece, [x, x + 10, x + 19, x + 20])) &&
        (str[nextCurrentPiece[0]] == 'x' ||
            str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 11, x + 21]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 10, x + 20])) &&
        (str[nextCurrentPiece[1]] == 'x' ||
            str[nextCurrentPiece[2]] == 'x' ||
            str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }

    if ((eq(nextCurrentPiece, [x, x + 10, x + 11, x + 12]) ||
            eq(nextCurrentPiece, [x, x + 9, x + 10, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 8, x + 9, x + 10])) &&
        (str[nextCurrentPiece[0]] == 'x' || str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 10, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 9, x + 10]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 11, x + 12])) &&
        (str[nextCurrentPiece[1]] == 'x' || str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 2, x + 12]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 2, x + 11]) ||
            eq(nextCurrentPiece, [x, x + 1, x + 2, x + 10])) &&
        (str[nextCurrentPiece[2]] == 'x' || str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }
    if ((eq(nextCurrentPiece, [x, x + 1, x + 2, x + 3])) &&
        (str[nextCurrentPiece[3]] == 'x')) {
      return true;
    }

    return false;
  }
}
