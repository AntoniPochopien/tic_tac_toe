int checkIfWin(List<int> list, int player) {
  //horizontal check
  if (list[0] == player && list[1] == player && list[2] == player) {
    return player;
  }
  if (list[3] == player && list[4] == player && list[5] == player) {
    return player;
  }
  if (list[6] == player && list[7] == player && list[8] == player) {
    return player;
  }
  //vertical check
  if (list[0] == player && list[3] == player && list[6] == player) {
    return player;
  }
  if (list[1] == player && list[4] == player && list[7] == player) {
    return player;
  }
  if (list[2] == player && list[5] == player && list[8] == player) {
    return player;
  }
  //cross check
  if (list[0] == player && list[4] == player && list[8] == player) {
    return player;
  }
  if (list[2] == player && list[4] == player && list[6] == player) {
    return player;
  }
  if (!list.contains(0)) {
    return 3;
  } else {
    return 0;
  }
}
