import 'dart:io';
import 'package:easy_widget/easy_widget_enum.dart';
import 'package:easy_widget/easy_widget_hepler.dart';
import 'package:easy_widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'easy_widget_signleton.dart';

extension EasyNums on num {
  /// Returns a double, which is calculated as
  ///
  /// (Screen Height) * (input / Average Screen Height)
  ///
  /// Default Average Screen Height = 720
  double get hWise => ((AppContext.sHeight ?? AppContext.designHeight) *
      (this / AppContext.designHeight));

  /// Returns a double, which is calculated as
  ///
  /// (Screen Width) * (input / Average Screen Width)
  ///
  /// Default Average Screen Width = 360
  double get wWise => ((AppContext.sWidth ?? AppContext.designWidth) *
      (this / AppContext.designWidth));

  /// Creates a Sizedbox of [this] height
  SizedBox get hGap => SizedBox(height: this.hWise);

  /// Creates a Sizedbox of [this] width
  SizedBox get wGap => SizedBox(width: this.wWise);

  ///Circular Border radius
  BorderRadius get cBorderRadius => BorderRadius.circular(this.toDouble());

  ///Circular Radius
  Radius get cRadius => Radius.circular(this.toDouble());

  /// Duration in Seconds
  Duration get seconds => Duration(seconds: this.toInt());

  /// Duration in Milliseconds
  Duration get milliSeconds => Duration(milliseconds: this.toInt());

  /// Duration in Microseconds
  Duration get microSeconds => Duration(microseconds: this.toInt());

  /// Duration in Hours
  Duration get hours => Duration(hours: this.toInt());

  /// Duration in Days
  Duration get days => Duration(days: this.toInt());

  /// Padding top
  EdgeInsets get padT => EdgeInsets.only(top: this.toDouble());

  /// Padding right
  EdgeInsets get padR => EdgeInsets.only(right: this.toDouble());

  /// Padding bottom
  EdgeInsets get padB => EdgeInsets.only(bottom: this.toDouble());

  /// Padding left
  EdgeInsets get padL => EdgeInsets.only(left: this.toDouble());

  /// Padding All
  EdgeInsets get padAll => EdgeInsets.all(this.toDouble());

  /// Padding symmetric vertical
  EdgeInsets get padSV => EdgeInsets.symmetric(vertical: this.toDouble());

  /// Padding symmetric horizontal
  EdgeInsets get padSH => EdgeInsets.symmetric(horizontal: this.toDouble());
}

// on context
extension EasyContext on BuildContext {
  /// Returns screen width
  double get w {
    return MediaQuery.of(this).size.width;
  }

  /// Returns screen height
  double get h {
    return MediaQuery.of(this).size.height;
  }

  /// Returns screen orientation
  Orientation get orientation {
    return MediaQuery.of(this).orientation;
  }

  /// Height of Keyboard
  double get kHeight => MediaQuery.of(this).viewInsets.bottom;

  /// Check if Keyboard is visible.
  bool get kVisible => MediaQuery.of(this).viewInsets.bottom != 0;

  /// Pop
  void pop<T extends Object>([T? results]) => Navigator.of(this).pop(results);

  /// Push
  Future<T?> push<T extends Object>(Widget page,
          {EasyTransitionType? transitionType}) =>
      Navigator.of(this).push(EasyPageTransition(
          child: page,
          childCurrent: this.widget,
          type: transitionType ??= Platform.isAndroid
              ? EasyTransitionType.bottomToTop
              : EasyTransitionType.rightToLeft));

  /// PushReplace
  Future<T?> pushReplacement<T extends Object, TO extends Object>(Widget page,
          {EasyTransitionType? transitionType, TO? result}) =>
      Navigator.of(this).pushReplacement(
          EasyPageTransition(
              child: page,
              childCurrent: this.widget,
              type: transitionType ??= Platform.isAndroid
                  ? EasyTransitionType.bottomToTop
                  : EasyTransitionType.rightToLeft),
          result: result);

  /// PushReplace
  Future<T?> pushAndRemoveUntil<T extends Object, TO extends Object>(
          Widget page, bool Function(Route<dynamic>) predicate,
          {EasyTransitionType? transitionType}) =>
      Navigator.of(this).pushAndRemoveUntil(
          EasyPageTransition(
              child: page,
              childCurrent: this.widget,
              type: transitionType ??= Platform.isAndroid
                  ? EasyTransitionType.bottomToTop
                  : EasyTransitionType.rightToLeft),
          (route) => predicate(route));

  /// PushNamed
  Future<T?> pushNamed<T extends Object?>(String routeName,
          {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  /// PushReplaceMentNamed
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName,
          arguments: arguments, result: result);

  /// PopAndPushNamed
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      Navigator.of(this)
          .popAndPushNamed(routeName, arguments: arguments, result: result);

  /// Display simple snackbar
  ///
  /// if `textStyle` is given then `fontColor` and `fontSize` will be ignored
  ///
  /// Default `Duration = 3 Seconds`
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSimpleSnackBar(
      String message,
      {double? fontSize,
      Color? fontColor,
      TextStyle? textStyle,
      Color? backgroundColor,
      Duration? duration}) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle ??= TextStyle(fontSize: fontSize, color: fontColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration ??= 3.seconds,
      ),
    );
  }

  /// Returns navigator
  NavigatorState get navigator => Navigator.of(this);

  /// Returns theme
  ThemeData get theme => Theme.of(this);

  Future<T?> pushAll<T extends Object>(List<Widget> pages,
      {EasyTransitionType? transitionType}) {
    for (var i = 0; i < pages.length - 1; i++) {
      Navigator.of(this).push(EasyPageTransition(
          child: pages[i],
          childCurrent: this.widget,
          duration: 0.seconds,
          type: transitionType ??= Platform.isAndroid
              ? EasyTransitionType.bottomToTop
              : EasyTransitionType.rightToLeft));
    }
    return Navigator.of(this).push(EasyPageTransition(
        child: pages[pages.length - 1],
        childCurrent: this.widget,
        duration: 200.milliSeconds,
        type: transitionType ??= Platform.isAndroid
            ? EasyTransitionType.bottomToTop
            : EasyTransitionType.rightToLeft));
  }

  Future<T?> pushNamedAll<T extends Object?>(
      {required List<String> routeNames,
      required List<Map<dynamic, dynamic>> arguments}) {
    assert(routeNames.length == arguments.length,
        'routeNames length should be equal to arguments lenght');
    for (var i = 0; i < routeNames.length - 1; i++) {
      arguments[i].putIfAbsent('etduration', () => 0.seconds);
      this.pushNamed(routeNames[i], arguments: arguments[i]);
    }
    arguments[arguments.length - 1]
        .putIfAbsent('etduration', () => 200.milliSeconds);
    return this.pushNamed(routeNames[routeNames.length - 1],
        arguments: arguments[arguments.length - 1]);
  }
}

// on object?
extension EasyObject on Object? {
  /// check if Object is Null
  bool get isNull => this == null;

  /// check if Object is not Null
  bool get isNotNull => this != null;
}

// on widget
extension EasyWidgets on Widget {
  /// onTap Gesture
  GestureDetector onTap(void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  /// Ink tap with splash effect
  ///
  /// If this is used on Container or Card type widget, then make sure that you
  /// don't set the color of that widget, instead pass the color here.
  ///
  ///Colors are theme default
  ///
  /// It's preffered that padding should be use on widgets like `Text`, `Icon` etc
  Widget inkTap({
    void Function()? onTap,
    void Function()? onDoubleTap,
    void Function()? onLongPress,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    EdgeInsets? padding,
    bool enableFeedback = true,
    double? feedbackDuration = 0.5,
  }) {
    return Material(
      color: backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        enableFeedback: enableFeedback,
        borderRadius: borderRadius,
        highlightColor: highlightColor,
        splashColor: splashColor,
        hoverColor: hoverColor,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        child: padding == null ? this : this.padd(padding),
      ),
    );
  }

  /// Easilty handle normal and [swipe] Gesture
  Widget easyGesture(
      {Key? key,
      void Function()? onTap,
      void Function()? onDoubleTap,
      void Function()? onLongPress,
      void Function(EasySwipeDirection)? onHorizontalSwipe,
      void Function(EasySwipeDirection)? onVerticalSwipe,
      double horizontalThreshold = 40,
      double verticalThreshold = 40}) {
    return SimpleGestureDetector(
      key: key,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHorizontalSwipe: onHorizontalSwipe != null
          ? (direction) => onHorizontalSwipe(changeSwipeDirectionAlt(direction))
          : null,
      onVerticalSwipe: onVerticalSwipe != null
          ? (direction) => onVerticalSwipe(changeSwipeDirectionAlt(direction))
          : null,
      swipeConfig: SimpleSwipeConfig(
        horizontalThreshold: horizontalThreshold,
        verticalThreshold: verticalThreshold,
      ),
      child: this,
    );
  }

  /// Padding
  Padding padd(EdgeInsets insets) => Padding(
        padding: insets,
        child: this,
      );

  /// Padding only
  Padding paddO(
      {double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: this,
    );
  }

  /// Padding Symmetric
  Padding paddS({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: this,
    );
  }

  Align get alignCR {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Align get alignCL {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Align get alignC {
    return Center(
      child: this,
    );
  }

  Align get alignBR {
    return Align(
      alignment: Alignment.bottomRight,
      child: this,
    );
  }

  Align get alignBL {
    return Align(
      alignment: Alignment.bottomLeft,
      child: this,
    );
  }

  Align get alignBC {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }

  Align get alignTR {
    return Align(
      alignment: Alignment.topRight,
      child: this,
    );
  }

  Align get alignTL {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align get alignTC {
    return Align(
      alignment: Alignment.topCenter,
      child: this,
    );
  }
}

// on string
extension EasyString on String? {
  /// check if String is Null and Empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// print the string
  void get log => print(this);
}

extension EasyList on List? {
  /// check if List is Null or Empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension EasyExtenionListString on List<String> {
  /// Returns a Query string from list of String.
  ///
  /// Example = ["id=1","code=528"] => "&id=1&code=528"
  String get makeQuery {
    String _query = '';
    this.forEach((query) {
      _query = '$_query&$query';
    });
    return _query;
  }

  String seperateBy(String seperator) {
    if (this.isNull) return '';
    String toRet = '';
    for (var i = 0; i < this.length; i++) {
      toRet += this[i];
      if (i != this.length - 1) {
        toRet += ' $seperator ';
      }
    }
    return toRet;
  }
}

// on list of double
extension EasyExtensionListDouble on List<num> {
  /// creates a `SizedBox` from List of Int.
  ///
  /// 0th element of list is taken as height and 1st element as width.
  Widget get easyBox {
    assert(this.length == 2, "List should have exactly 2 elements");
    return SizedBox(
      height: this[0].toDouble().hWise,
      width: this[1].toDouble().wWise,
    );
  }

  /// creates symmetric padding
  ///
  /// 0th element of list is taken as vertical and 1st element as horizontal.
  EdgeInsets get padSVH {
    assert(this.length == 2, "List should have exactly 2 elements");
    return EdgeInsets.symmetric(
      vertical: this[0].toDouble(),
      horizontal: this[1].toDouble(),
    );
  }

  /// creates symmetric padding
  ///
  /// 0th element of list is taken as horizontal and 1st element as vertical.
  EdgeInsets get padSHV {
    assert(this.length == 2, "List should have exactly 2 elements");
    return EdgeInsets.symmetric(
      horizontal: this[0].toDouble(),
      vertical: this[1].toDouble(),
    );
  }

  /// creates padding
  ///
  /// 1st element = Left
  ///
  /// 2nd element = Top
  ///
  /// 3rd element = Right
  ///
  /// 4th element = Bottom
  EdgeInsets get padLTRB {
    assert(this.length == 4, "List should have exactly 4 elements");
    return EdgeInsets.fromLTRB(this[0].toDouble(), this[1].toDouble(),
        this[2].toDouble(), this[3].toDouble());
  }
}
