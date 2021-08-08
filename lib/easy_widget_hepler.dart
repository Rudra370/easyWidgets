import 'package:easy_widget/easy_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

PageTransitionType changeTransitionType(EasyTransitionType type) {
  switch (type) {
    case EasyTransitionType.bottomToTop:
      return PageTransitionType.bottomToTop;
    case EasyTransitionType.topToBottom:
      return PageTransitionType.topToBottom;
    case EasyTransitionType.rightToLeft:
      return PageTransitionType.rightToLeft;
    case EasyTransitionType.leftToRight:
      return PageTransitionType.leftToRight;
    case EasyTransitionType.fade:
      return PageTransitionType.fade;
    case EasyTransitionType.leftToRightWithFade:
      return PageTransitionType.leftToRightWithFade;
    case EasyTransitionType.rightToLeftWithFade:
      return PageTransitionType.rightToLeftWithFade;
    case EasyTransitionType.rotate:
      return PageTransitionType.rotate;
    case EasyTransitionType.scale:
      return PageTransitionType.scale;
    case EasyTransitionType.size:
      return PageTransitionType.size;
    case EasyTransitionType.leftToRightJoined:
      return PageTransitionType.leftToRightJoined;
    case EasyTransitionType.rightToLeftJoined:
      return PageTransitionType.rightToLeftJoined;
    default:
      return PageTransitionType.topToBottom;
  }
}

SwipeDirection changeSwipeDirection(EasySwipeDirection direction) {
  switch (direction) {
    case EasySwipeDirection.left:
      return SwipeDirection.left;
    case EasySwipeDirection.right:
      return SwipeDirection.right;
    case EasySwipeDirection.up:
      return SwipeDirection.up;
    case EasySwipeDirection.down:
      return SwipeDirection.down;
  }
}
EasySwipeDirection changeSwipeDirectionAlt(SwipeDirection direction) {
  switch (direction) {
    case SwipeDirection.left:
      return EasySwipeDirection.left;
    case SwipeDirection.right:
      return EasySwipeDirection.right;
    case SwipeDirection.up:
      return EasySwipeDirection.up;
    case SwipeDirection.down:
      return EasySwipeDirection.down;
  }
}
