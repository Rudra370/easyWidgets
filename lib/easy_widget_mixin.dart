import 'dart:async';

import 'package:easy_widgets/easy_widget.dart';
import 'package:flutter/material.dart';
import 'easy_widget_enum.dart';
import 'easy_widget_extensions.dart';

mixin EasyMixin<T extends StatefulWidget> on State<T> {
  /// Returns screen width
  double get screenW {
    return context.w;
  }

  /// Returns screen height
  double get screenH {
    return context.h;
  }

  /// Returns screen orientation
  Orientation get orientation {
    return context.orientation;
  }

  /// Height of Keyboard
  double get kHeight => context.kHeight;

  /// Check if Keyboard is visible.
  bool get kVisible => context.kVisible;

  /// Pop
  void pop<T extends Object>([T? results]) => context.pop(results);

  /// Pop
  void get back => context.pop();

  /// Push
  Future<T?> push<T extends Object>(Widget page,
          {EasyTransitionType? transitionType}) =>
      context.push(page, transitionType: transitionType);

  /// PushReplace
  Future<T?> pushReplacement<T extends Object, TO extends Object>(Widget page,
          {EasyTransitionType? transitionType, TO? result}) =>
      context.pushReplacement(page,
          transitionType: transitionType, result: result);

  /// PushReplace
  Future<T?> pushAndRemoveUntil<T extends Object, TO extends Object>(
          Widget page, bool Function(Route<dynamic>) predicate,
          {EasyTransitionType? transitionType}) =>
      context.pushAndRemoveUntil(
        page,
        (route) => predicate(route),
        transitionType: transitionType,
      );

  /// PushNamed
  Future<T?> pushNamed<T extends Object?>(String routeName,
          {Object? arguments}) =>
      context.pushNamed(routeName, arguments: arguments);

  /// PushReplaceMentNamed
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      context.pushReplacementNamed(routeName,
          arguments: arguments, result: result);

  /// PopAndPushNamed
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      context.popAndPushNamed(routeName, arguments: arguments, result: result);

  /// returns navigator
  NavigatorState get navigator => context.navigator;

  /// returns theme
  ThemeData get theme => context.theme;

  /// Display simple snackbar
  ///
  /// if `textStyle` is given then `fontColor` and `fontSize` will be ignored
  ///
  /// Default `Duration = 3 Seconds`
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> easySnackBar(
      String message,
      {double? fontSize,
      Color? fontColor,
      TextStyle? textStyle,
      Color? backgroundColor,
      Duration? duration}) {
    return context.showSimpleSnackBar(
      message,
      fontSize: fontSize,
      fontColor: fontColor,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      duration: duration,
    );
  }

  /// Loader at the center of the screen
  void get easyLoader {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CircularProgressIndicator().alignC;
      },
    );
  }

  /// Loader at the center of the screen that can't be dismissed with back button
  void get easyRestrictedLoader {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: CircularProgressIndicator().alignC);
      },
    );
  }

  /// Loader at the center of the screen
  void easyColorLoader(
      {required Color color,
      Color barrierColor = Colors.black45,
      bool restricted = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: barrierColor,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => !restricted,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(color),
          ).alignC,
        );
      },
    );
  }

  /// default padding is `(context.w * 0.16).padSH`
  /// default content padding is `[10, 10].padSHV`
  /// On tap to close dialog is default on `closeIcon`
  Future<T?> easyDialog<T>({
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    Color backgroundColor = Colors.white,
    Color barrierColor = Colors.black54,
    List<Widget> children = const [],
    bool barrierDismissible = true,
    bool useSafeArea = true,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    Widget? closeIcon,
    bool closeIconVisible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      builder: (context) {
        return Dialog(
          insetPadding: padding ?? (context.w * 0.16).padSH,
          elevation: 0,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: 4.cBorderRadius,
          ),
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (closeIconVisible) ...[
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: (closeIcon ??
                          Icon(
                            Icons.close,
                            color: Colors.grey[400],
                            size: 16.hWise,
                          ))
                      .onTap(() => back)
                      .alignTR,
                ),
                5.hGap,
              ],
              ...children,
            ],
          ).padd(contentPadding ?? [10.wWise, 10.hWise].padSHV),
        );
      },
    );
  }

  /// will throw an error if `showSnackBarOnError` is true and `snackbarMessage` is not given
  ///
  /// Default snackbar will be used if snackbar is null
  ///
  /// user will not be able to close the indicator with back button if `restrictedIndicator` is true, recommended.
  Future<dynamic> easyFuture<Z>({
    required Future<Z> Function() future,
    Function()? returnOnError,
    bool showSnackBarOnError = false,
    String Function(Exception e)? snackBarMessage,
    Color? snackBarColor = Colors.red,
    ScaffoldFeatureController Function(Exception e)? snackbar,
    bool indicatorWhileFuture = false,
    bool restrictedIndicator = true,
    Color? indicatorColor,
  }) async {
    assert(
        (showSnackBarOnError && snackBarMessage.isNotNull) ||
            (!showSnackBarOnError),
        'showSnackerBarOnError is true but snackBarMessage is not provided');
    if (indicatorWhileFuture)
      indicatorColor.isNotNull
          ? easyColorLoader(
              color: indicatorColor!, restricted: restrictedIndicator)
          : restrictedIndicator
              ? easyRestrictedLoader
              : easyLoader;
    try {
      Z toRet = await future();
      if (indicatorWhileFuture) back;
      return toRet;
    } on Exception catch (e) {
      if (indicatorWhileFuture) back;
      if (showSnackBarOnError) {
        snackbar.isNotNull
            ? snackbar!(e)
            : easySnackBar(
                snackBarMessage!(e),
                backgroundColor: snackBarColor,
              );
      }
    }
    return returnOnError != null ? returnOnError() : null;
  }

  @override
  void didChangeDependencies() {
    EasyWidget.initiate(context);
    super.didChangeDependencies();
  }
}
