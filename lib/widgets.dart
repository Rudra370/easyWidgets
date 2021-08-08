import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'easy_widget_extensions.dart';
import 'easy_widget_hepler.dart';
import 'easy_widget.dart';

///Helps you create easy page transitions with some default transitions.
class EasyPageTransition<T> extends PageRouteBuilder<T> {
  /// Child for your next page
  final Widget child;

  /// Child for your next page
  ///
  /// Required when using rightToLeftJoined or leftToRightJoined
  final Widget? childCurrent;

  /// Transition types
  ///  fade,rightToLeft,leftToRight, upToDown,downToUp,scale,rotate,size,rightToLeftWithFade,leftToRightWithFade
  final EasyTransitionType type;

  /// Curves for transitions
  final Curve curve;

  /// Aligment for transitions, default is center
  ///
  /// Align transitions like scale, rotate, size
  final Alignment? alignment;

  /// Duration for your transition default is 300 ms
  final Duration duration;

  /// Duration for your pop transition default is 300 ms
  final Duration reverseDuration;

  /// Context for inheret theme
  final BuildContext? ctx;

  /// Optional inheret teheme
  final bool inheritTheme;
  EasyPageTransition({
    Key? key,
    required this.child,
    required this.type,
    this.childCurrent,
    this.ctx,
    this.inheritTheme = false,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(
            pageBuilder: (context, animation, secondaryAnimation) {
              return inheritTheme
                  ? InheritedTheme.captureAll(
                      ctx!,
                      child,
                    )
                  : child;
            },
            transitionDuration: settings != null &&
                    (settings.arguments is Map) &&
                    (settings.arguments as Map)['etduration'] != null
                ? (settings.arguments as Map)['etduration']
                : duration,
            reverseTransitionDuration: reverseDuration,
            settings: settings,
            maintainState: true,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    PageTransition(
                            child: child,
                            childCurrent: childCurrent,
                            alignment: alignment,
                            ctx: ctx,
                            curve: curve,
                            duration: duration,
                            inheritTheme: inheritTheme,
                            key: key,
                            reverseDuration: reverseDuration,
                            settings: settings,
                            type: changeTransitionType(type))
                        .transitionsBuilder(
                            context, animation, secondaryAnimation, child));
}

/// Easy and fast to manage Container
class EasyContainer extends StatefulWidget {
  /// Whether to have animation on Container
  ///
  /// Default is `false`
  final bool animated;

  ///Duration for animation
  ///
  ///default is `500.milliSeconds`
  final Duration? animationDuration;

  final double? height;
  final double? width;

  /// whether to use `height` and `width` as responsive
  ///
  /// if useResponsiveSize is true `height` and `width` will be used as `10.hWise` and `10.wWise` responsively
  ///
  /// default is `true`
  final bool useResponsiveSize;

  /// default is `white`
  final Color? backgroundColor;

  final Widget? child;

  final Function()? onTap;

  final Function()? onLongTap;

  final Function()? onDoubleTap;

  /// default is `center`
  final Alignment alignment;

  /// if gradient is available then splash color will not work on Gestures
  final Gradient? gradient;

  final BoxBorder? boxBorder;

  final BorderRadius? borderRadius;

  final BoxShape boxShape;

  final List<BoxShadow>? boxShadows;

  final double? maxHeight;

  final double? maxWidth;

  final double? minHeight;

  final double? minWidth;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final Matrix4? transform;

  final AlignmentGeometry? transformAlignment;

  /// function to be executed on the end of the animation
  final Function()? onEnd;

  final Curve animationCurve;

  /// Only works if gradient is null
  ///
  ///Theme dafault color
  ///
  /// Try transparent
  final Color? highlightColor;

  /// Only works if gradient is null
  ///
  /// Theme dafault color.
  final Color? splashColor;

  /// Only works if gradient is null
  ///
  /// Theme dafault color
  final Color? hoverColor;

  /// Feedback for Ink tap
  final bool feedBack;

  final bool disableRippleEffect;

  final double? elevation;

  const EasyContainer({
    Key? key,
    this.animated = false,
    this.animationDuration,
    this.height,
    this.width,
    this.useResponsiveSize = true,
    this.backgroundColor = Colors.white,
    this.child,
    this.onTap,
    this.onLongTap,
    this.onDoubleTap,
    this.alignment = Alignment.center,
    this.gradient,
    this.boxBorder,
    this.borderRadius,
    this.boxShape = BoxShape.rectangle,
    this.boxShadows,
    this.maxHeight,
    this.maxWidth,
    this.minHeight,
    this.minWidth,
    this.padding,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.onEnd,
    this.animationCurve = Curves.linear,
    this.highlightColor,
    this.splashColor,
    this.hoverColor,
    this.feedBack = true,
    this.disableRippleEffect = false,
    this.elevation,
  }) : super(key: key);

  @override
  _EasyContainerState createState() => _EasyContainerState();
}

class _EasyContainerState extends State<EasyContainer> {
  @override
  Widget build(BuildContext context) {
    EasyWidget.initiate(context);
    double? _height =
        widget.useResponsiveSize ? (widget.height ?? 0).hWise : widget.height;
    double? _width =
        widget.useResponsiveSize ? (widget.width ?? 0).wWise : widget.width;
    bool _isGestured = widget.onTap != null ||
        widget.onLongTap != null ||
        widget.onDoubleTap != null;
    BoxDecoration _decoration = BoxDecoration(
      color: _isGestured ? null : widget.backgroundColor,
      gradient: widget.gradient,
      border: widget.boxBorder,
      borderRadius: widget.borderRadius,
      shape: widget.boxShape,
      boxShadow: widget.boxShadows,
    );
    BoxConstraints? _constraints = widget.maxHeight.isNotNull ||
            widget.maxWidth.isNotNull ||
            widget.minHeight.isNotNull ||
            widget.minWidth.isNotNull
        ? BoxConstraints(
            maxHeight: widget.useResponsiveSize
                ? widget.maxHeight.isNull
                    ? double.infinity
                    : widget.maxHeight!.hWise
                : widget.maxHeight ?? double.infinity,
            maxWidth: widget.useResponsiveSize
                ? widget.maxWidth.isNull
                    ? double.infinity
                    : widget.maxWidth!.wWise
                : widget.maxHeight ?? double.infinity,
            minHeight: widget.useResponsiveSize
                ? widget.minHeight.isNull
                    ? double.infinity
                    : widget.minHeight!.hWise
                : widget.maxHeight ?? 0.0,
            minWidth: widget.useResponsiveSize
                ? widget.minWidth.isNull
                    ? double.infinity
                    : widget.minWidth!.hWise
                : widget.maxHeight ?? 0.0,
          )
        : null;

    Widget _toRet = widget.animated
        ? AnimatedContainer(
            key: widget.key,
            duration: widget.animationDuration ?? 3.seconds,
            height: _height,
            width: _width,
            alignment: widget.alignment,
            decoration: _decoration,
            constraints: _constraints,
            padding: widget.padding,
            margin: widget.margin,
            transform: widget.transform,
            transformAlignment: widget.transformAlignment,
            onEnd: widget.onEnd,
            curve: widget.animationCurve,
            child: widget.child,
          )
        : Container(
            key: widget.key,
            height: _height,
            width: _width,
            alignment: widget.alignment,
            decoration: _decoration,
            constraints: _constraints,
            padding: widget.padding,
            margin: widget.margin,
            transform: widget.transform,
            transformAlignment: widget.transformAlignment,
            child: widget.child,
          );
    _toRet = widget.gradient.isNotNull || widget.disableRippleEffect
        ? _toRet.easyGesture(
            onTap: widget.onTap,
            onDoubleTap: widget.onDoubleTap,
            onLongPress: widget.onLongTap,
          )
        : _toRet.inkTap(
            onTap: widget.onTap,
            onDoubleTap: widget.onDoubleTap,
            onLongPress: widget.onLongTap,
            backgroundColor: widget.backgroundColor,
            borderRadius: widget.borderRadius,
            highlightColor: widget.highlightColor,
            hoverColor: widget.hoverColor,
            splashColor: widget.splashColor,
            enableFeedback: widget.feedBack,
          );
    if (widget.elevation.isNotNull)
      _toRet = Material(
        color: Colors.transparent,
        borderRadius: widget.borderRadius,
        elevation: widget.elevation!,
        child: _toRet,
      );
    return _toRet;
  }
}

class EasyGesture extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final void Function(EasySwipeDirection)? onHorizontalSwipe;
  final void Function(EasySwipeDirection)? onVerticalSwipe;
  final double horizontalThreshold;
  final double verticalThreshold;
  final Widget child;

  const EasyGesture(
      {Key? key,
      this.onTap,
      this.onDoubleTap,
      this.onLongPress,
      this.onHorizontalSwipe,
      this.onVerticalSwipe,
      this.horizontalThreshold = 40,
      this.verticalThreshold = 40,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyWidget.initiate(context);
    return SimpleGestureDetector(
      key: key,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHorizontalSwipe: onHorizontalSwipe != null
          ? (direction) =>
              onHorizontalSwipe!(changeSwipeDirectionAlt(direction))
          : null,
      onVerticalSwipe: onVerticalSwipe != null
          ? (direction) => onVerticalSwipe!(changeSwipeDirectionAlt(direction))
          : null,
      swipeConfig: SimpleSwipeConfig(
        horizontalThreshold: horizontalThreshold,
        verticalThreshold: verticalThreshold,
      ),
      child: child,
    );
  }
}

class EasyInkTap extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final EdgeInsets? padding;
  final bool enableFeedback = true;
  final double feedbackDuration;
  final Widget child;

  const EasyInkTap(
      {Key? key,
      this.onTap,
      this.onDoubleTap,
      this.onLongPress,
      this.backgroundColor,
      this.borderRadius,
      this.splashColor,
      this.highlightColor,
      this.hoverColor,
      this.padding,
      this.feedbackDuration = 0.5,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyWidget.initiate(context);
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
        child: padding == null ? child : child.padd(padding!),
      ),
    );
  }
}

class EasyPadding extends StatelessWidget {
  final Widget child;
  final double? all;
  final double? horizontal;
  final double? vertical;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  const EasyPadding(
      {Key? key,
      required this.child,
      this.all,
      this.horizontal,
      this.vertical,
      this.top,
      this.right,
      this.bottom,
      this.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyWidget.initiate(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ?? horizontal ?? all ?? 0,
        top ?? vertical ?? all ?? 0,
        right ?? horizontal ?? all ?? 0,
        bottom ?? vertical ?? all ?? 0,
      ),
      child: child,
    );
  }
}

///Since it has `isScrollable`, therefore it can be used to make scrollable optional
///
/// `itemBuilder` and `separatorBuilder` will only work if isScrollable is true.
class EasyScrollList extends StatelessWidget {
  final List<Widget>? children;

  /// `itemCount` must not be `null`
  final IndexedWidgetBuilder? itemBuilder;

  /// `itemCount` must not be `null`
  ///
  /// will work if `isScrollable` is true
  final IndexedWidgetBuilder? separatorBuilder;

  /// will work if `isScrollable` is false
  final Widget? separator;
  final bool isScrollable;
  final EdgeInsets scrollViewpadding;
  final Axis scrollDirection;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final int? itemCount;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;

  /// will only work if no builder is used
  final CrossAxisAlignment? crossAxisAlignment;

  /// will only work if no builder is used
  final MainAxisAlignment? mainAxisAlignment;

  /// will take all the available space
  ///
  /// basically, wrapped inside `Expanded`
  final bool expand;
  final Function()? onEndOfPage;
  final bool showLoadingSpinnerAtEnd;

  /// default is `CircularProgressIndicator`
  final Widget? loadingSpinner;

  EasyScrollList({
    Key? key,
    this.isScrollable = false,
    this.children,
    this.scrollViewpadding = EdgeInsets.zero,
    this.onEndOfPage,
    this.scrollDirection = Axis.vertical,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.itemBuilder,
    this.separatorBuilder,
    this.itemCount,
    this.shrinkWrap = true,
    this.separator,
    this.scrollController,
    this.scrollPhysics,
    this.expand = false,
    this.showLoadingSpinnerAtEnd = false,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.loadingSpinner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyWidget.initiate(context);
    var toRet;
    List<Widget> uChildren = [];
    int length = (children ?? []).length;
    if (length != 0) {
      for (var i = 0; i < length; i++) {
        uChildren.add(children![i]);
        if (i != length - 1 && separator != null) {
          uChildren.add(separator!);
        }
      }
      if (showLoadingSpinnerAtEnd)
        uChildren.add(loadingSpinner ?? CircularProgressIndicator().alignC);
    }
    toRet = scrollDirection == Axis.vertical
        ? Column(
            key: key,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            children: uChildren,
          )
        : Row(
            key: key,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            children: uChildren,
          );
    if (isScrollable) {
      assert((itemBuilder != null && itemCount != null) || children != null,
          'Either itemBuiler or children should be provided if isScrollable is true');
      assert(
          separatorBuilder == null ||
              (separatorBuilder != null && itemCount != null),
          'itemCount must be provided if using seperatorBuilder');
      if (itemCount == null) {
        toRet = SingleChildScrollView(
          child: toRet,
          controller: scrollController,
          padding: scrollViewpadding,
          physics: scrollPhysics,
          scrollDirection: scrollDirection,
          keyboardDismissBehavior: keyboardDismissBehavior,
        );
      } else {
        toRet = ListView.builder(
          key: key,
          itemBuilder: getItemBuilder,
          itemCount: showLoadingSpinnerAtEnd ? itemCount! + 1 : itemCount!,
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection,
          keyboardDismissBehavior: keyboardDismissBehavior,
          controller: scrollController,
          physics: scrollPhysics,
          padding: scrollViewpadding,
        );
        if (separatorBuilder != null) {
          toRet = ListView.separated(
            key: key,
            itemBuilder: getItemBuilder,
            itemCount: showLoadingSpinnerAtEnd ? itemCount! + 1 : itemCount!,
            shrinkWrap: shrinkWrap,
            separatorBuilder: separatorBuilder!,
            scrollDirection: scrollDirection,
            keyboardDismissBehavior: keyboardDismissBehavior,
            controller: scrollController,
            physics: scrollPhysics,
            padding: scrollViewpadding,
          );
        }
      }
    }

    if (onEndOfPage != null) {
      assert(isScrollable == true,
          'isScrollable should be true if you\'re using onEndOfPage');
      toRet = LazyLoadScrollView(
        onEndOfPage: onEndOfPage!,
        scrollDirection: scrollDirection,
        child: toRet,
      );
    }

    if (expand)
      toRet = Expanded(
        child: toRet,
      );

    return toRet;
  }

  Widget Function(BuildContext context, int index) get getItemBuilder {
    return (context, index) {
      if (showLoadingSpinnerAtEnd && index == itemCount!)
        return loadingSpinner ?? CircularProgressIndicator().alignC;
      return itemBuilder != null
          ? itemBuilder!(context, index)
          : children![index];
    };
  }

  factory EasyScrollList.optionalScroll({
    required List<Widget> children,
    required bool isScrollable,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    Axis scrollDirection = Axis.vertical,
    Widget? seperator,
    Function()? onEndOfPage,
    bool showLoadingSpinnerAtEnd = false,
    Widget? loadingSpinner,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool expand = false,
  }) {
    return EasyScrollList(
      children: children,
      isScrollable: isScrollable,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      scrollDirection: scrollDirection,
      separator: seperator,
      onEndOfPage: onEndOfPage,
      showLoadingSpinnerAtEnd: showLoadingSpinnerAtEnd,
      loadingSpinner: loadingSpinner,
      keyboardDismissBehavior: keyboardDismissBehavior,
      expand: expand,
    );
  }
}
