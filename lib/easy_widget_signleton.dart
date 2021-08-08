import 'package:flutter/cupertino.dart';
import 'easy_widget_extensions.dart';

class AppContext {
  static double? sHeight;
  static double? sWidth;
  static double designHeight = 720;
  static double designWidth = 360;
  static void init(BuildContext context,
      {double? designHeight, double? designWidth}) {
    sHeight = context.h;
    sWidth = context.w;
    AppContext.designHeight = designHeight ?? AppContext.designHeight;
    AppContext.designWidth = designWidth ?? AppContext.designWidth;
  }
}
