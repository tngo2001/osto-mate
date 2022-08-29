import 'package:flutter/material.dart';

class Scale {
  double _widthScale = 1.0;
  double _heightScale = 1.0;

  double get widthScale => _widthScale;
  double get heightScale => _heightScale;

  void setHeightScale(double heightScale) {
    _heightScale = heightScale;
  }

  void setWidthScale(double widthScale) {
    _widthScale = widthScale;
  }
}
