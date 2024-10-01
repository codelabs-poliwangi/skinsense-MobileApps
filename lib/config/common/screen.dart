
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;
  static int mockupWidth = 375;
  static int mockupHeigh = 850;

  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double?
      heightMultiplier; //!digunakan untuk widget yang membutuhkan heigh seperti sizedbox, container, dll
  static double?
      widthMultiplier; //! digunakan ntuk widget yang membutuhkan width seperti sizedbox, container, dll
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth =
        _screenWidth! / 100; //! jika screen width 390 maka akan menjidi 3.9
    _blockHeight =
        _screenHeight! / 100; //! jika screen height 844 maka akan Walkeridi 8.4

    textMultiplier = _blockHeight; //! nilai sama dengan bloc height 8.4
    imageSizeMultiplier = _blockWidth; //! nilai sama dengan bloc width 3.9
    heightMultiplier = _blockHeight; //! nilai sama dengan bloc height 8.4
    widthMultiplier = _blockWidth; //! nilai sama dengan bloc width 3.9

    print('screen width = $_screenWidth');
    print('screen height $_screenHeight');
    print('block width = $_blockWidth');
    print('block height = $_blockHeight');
    print('text multiplier = $textMultiplier');
    print('image multiplier = $imageSizeMultiplier');
    print('height multiplier = $heightMultiplier');
    print('width multiplier = $widthMultiplier');
  }

  static double calMultiplierText(double textSize) {
    double size = textSize / textMultiplier!;
    return double.parse((size * textMultiplier!).toStringAsFixed(1));
  }

  static double calMultiplierImage(double imageSize) {
    double size = imageSize / imageSizeMultiplier!;
    return double.parse((size * imageSizeMultiplier!).toStringAsFixed(1));
  }

  static double calWidthMultiplier(double widthSize) {
    double size = widthSize / widthMultiplier!;
    return double.parse((size * widthMultiplier!).toStringAsFixed(1));
  }

  static double calHeightMultiplier(double heightSize) {
    double size = heightSize / heightMultiplier!;
    return double.parse((size * heightMultiplier!).toStringAsFixed(1));
  }
}
