import 'package:collection/collection.dart';

class HitEdge {
  Function eq = const ListEquality().equals;
  var leftEdge = [
    0,
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100,
    110,
    120,
    130,
    140,
    150
  ];
  var rightEdge = [
    9,
    19,
    29,
    39,
    49,
    59,
    69,
    79,
    89,
    99,
    109,
    119,
    129,
    139,
    149,
    159
  ];
  hitBase(currentPiece, str) {
    var nextCurrentPiece = List.filled(4, 0, growable: false);
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

  hitSideLeft(currentPiece, str) {
    var nextCurrentPiece = List.filled(4, 0, growable: false);
    for (var i = 0; i < currentPiece.length; i++) {
      if (currentPiece[i] < 0) {
        return true;
      }
    }

    for (var i = 0; i < currentPiece.length; i++) {
      nextCurrentPiece[i] = currentPiece[i] - 1;
    }
    for (var i = 0; i < nextCurrentPiece.length; i++) {
      if (leftEdge.contains(currentPiece[i])) {
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

  hitSideRight(currentPiece, str) {
    var nextCurrentPiece = List.filled(4, 0, growable: false);
    for (var i = 0; i < currentPiece.length; i++) {
      if (currentPiece[i] > 159) {
        return true;
      }
    }

    for (var i = 0; i < currentPiece.length; i++) {
      nextCurrentPiece[i] = currentPiece[i] + 1;
    }
    for (var i = 0; i < nextCurrentPiece.length; i++) {
      if (rightEdge.contains(currentPiece[i])) {
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
