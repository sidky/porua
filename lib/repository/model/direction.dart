enum Direction {
  ltr, rtl
}

Direction directionFromString(String dir) {
  if (dir == "ltr") return Direction.ltr;
  else if (dir == "rtl") return Direction.rtl;
  else return null;
}