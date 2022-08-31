import 'package:flutter/material.dart';

Border determineBorder(idx) {
  Border determinedBorder = Border.all();
  final _borderSide = BorderSide(width: 2, color: Colors.black);

  switch (idx) {
    case 0:
      determinedBorder = Border(bottom: _borderSide, right: _borderSide);
      break;
    case 1:
      determinedBorder =
          Border(left: _borderSide, bottom: _borderSide, right: _borderSide);
      break;
    case 2:
      determinedBorder = Border(left: _borderSide, bottom: _borderSide);
      break;
    case 3:
      determinedBorder =
          Border(bottom: _borderSide, right: _borderSide, top: _borderSide);
      break;
    case 4:
      determinedBorder = Border(
          left: _borderSide,
          bottom: _borderSide,
          right: _borderSide,
          top: _borderSide);
      break;
    case 5:
      determinedBorder =
          Border(left: _borderSide, bottom: _borderSide, top: _borderSide);
      break;
    case 6:
      determinedBorder = Border(right: _borderSide, top: _borderSide);
      break;
    case 7:
      determinedBorder =
          Border(left: _borderSide, top: _borderSide, right: _borderSide);
      break;
    case 8:
      determinedBorder = Border(left: _borderSide, top: _borderSide);
      break;
  }

  return determinedBorder;
}
