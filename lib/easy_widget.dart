library easy_widget;

import 'package:flutter/widgets.dart';
import 'easy_widget_signleton.dart';
export 'easy_widget_extensions.dart';
export 'easy_widget_enum.dart';
export 'easy_widget_mixin.dart';
export 'widgets.dart';

class EasyWidget {
  EasyWidget._();
  static void initiate(BuildContext context,
      {double? designHeight, double? designWidth}) {
    AppContext.init(context,
        designHeight: designHeight, designWidth: designWidth);
  }
}
