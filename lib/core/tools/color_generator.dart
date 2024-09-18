import 'dart:ui';

class ColorGenerator{
  static Color fromString(String str){
    int hashCode = str.hashCode;
    int r = (hashCode & 0xFF0000) >> 16;
    int g = (hashCode & 0x00FF00) >> 8;
    int b = hashCode & 0x0000FF;
    return Color.fromRGBO(r, g, b,1);
  }
}